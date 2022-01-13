variable "primary_domain_name" {
  description = "A domain name for which the certificate should be issued"
  type        = string
}

variable "domain_names_to_zone_ids" {
  description = "Map of domain names (incl. `var.primary_domain_name`) to Route53 hosted zone IDs"
  type        = map(string)
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
