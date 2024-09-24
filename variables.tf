variable "default_tags" {
  type    = map(string)
  default = {}

  description = <<EOS
Map of tags assigned to all AWS resources created by this module.
EOS
}

variable "domain_names_to_zone_ids" {
  type = map(string)

  description = <<EOS
Map of domain names (incl. `var.primary_domain_name`) to Route53 hosted zone IDs.
EOS
}

variable "global_acm_certificate_tags" {
  type    = map(string)
  default = {}

  description = <<EOS
Map of tags assigned to the global ACM certificate created by this module. Tags in this map will override tags in `var.default_tags`.
EOS
}

variable "primary_domain_name" {
  type = string

  description = <<EOS
A domain name for which the certificate should be issued.
EOS
}

variable "regional_acm_certificate_tags" {
  type    = map(string)
  default = {}

  description = <<EOS
Map of tags assigned to the regional ACM certificate created by this module. Tags in this map will override tags in `var.default_tags`.
EOS
}
