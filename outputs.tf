output "global_acm_certificate_arn" {
  description = "The ARN of the global certificate"
  value       = aws_acm_certificate_validation.global.certificate_arn
}

output "regional_acm_certificate_arn" {
  description = "The ARN of the regional certificate"
  value       = aws_acm_certificate_validation.regional.certificate_arn
}
