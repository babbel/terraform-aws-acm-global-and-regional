resource "aws_acm_certificate" "global" {
  provider = aws.global

  domain_name               = var.primary_domain_name
  subject_alternative_names = setsubtract(keys(var.domain_names_to_zone_ids), [var.primary_domain_name])
  validation_method         = "DNS"

  tags = var.default_tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "regional" {
  provider = aws.regional

  domain_name               = var.primary_domain_name
  subject_alternative_names = setsubtract(keys(var.domain_names_to_zone_ids), [var.primary_domain_name])
  validation_method         = "DNS"

  tags = var.default_tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "validation" {
  provider = aws.global

  for_each = {
    for dvo in aws_acm_certificate.global.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = var.domain_names_to_zone_ids[each.key]
  name    = each.value.name
  type    = each.value.type
  ttl     = 60

  records = [each.value.record]
}

resource "aws_acm_certificate_validation" "global" {
  provider = aws.global

  certificate_arn = aws_acm_certificate.global.arn

  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn]
}

resource "aws_acm_certificate_validation" "regional" {
  provider = aws.regional

  certificate_arn = aws_acm_certificate.regional.arn

  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn]
}
