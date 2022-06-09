provider "aws" {
  alias  = "global"
  region = "local"
}

provider "aws" {
  alias  = "regional"
  region = "local"
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
