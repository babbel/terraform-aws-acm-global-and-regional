provider "aws" {
  alias = "global"
}

provider "aws" {
  alias = "regional"
}

module "acm" {
  source  = "./.."

  providers = {
    aws.global   = aws.global
    aws.regional = aws.regional
  }

  primary_domain_name = "example.com"

  domain_names_to_zone_ids = {
    "example.com"     = "XYZXYZXYZXYZXYZ"
    "www.example.com" = "YZXYZXYZXYZXYZX"
  }

  tags = {
    app  = "some-service"
    env  = "production"
  }
}
