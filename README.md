# AWS Certificate Manager (ACM) Terraform module creating and validating ACM certificates in two regions (usually `us-east-1` and another region)

Terraform module which creates two ACM certificates for same domain in different regions and validates them using Route53 DNS.

The typical use case is to create a certificate for CloudFront (which must be in `us-east-1`) and another certificate for a regional service like an ALB, ELB, or a regional endpoint of an API Gateway.

The challange is that the DNS records will be the same for certificates created in all regions. Thus, using two instances of the [`babbel/acm/aws`](https://registry.terraform.io/modules/babbel/acm/aws) module will not work properly as it would create two identical `aws_route53_record` resource for validation.

## Usage

As this module is supposed to create resources in two different regions, it needs two different AWS providers. Please make sure to specify the provider mapping in a `providers` block.

```tf
module "acm" {
  source  = "babbel/acm-global-and-regional/aws"
  version = "~> 1.1"

  providers = {
    aws.global   = ...
    aws.regional = ...
  }

  primary_domain_name = "example.com"

  domain_names_to_zone_ids = {
    "example.com"     = "XYZXYZXYZXYZXYZ"
    "www.example.com" = "YZXYZXYZXYZXYZX"
  }
}
```
