terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 4.0"
      configuration_aliases = [aws.global, aws.regional]
    }
  }
  required_version = ">= 0.15"
}
