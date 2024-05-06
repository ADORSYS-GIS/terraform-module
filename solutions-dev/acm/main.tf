locals {
  # Use existing (via data source) 
  use_existing_route53_zone = true

  domain = "sol.adorsys.com"

  # Removing trailing dot from domain - just to be sure :)
  domain_name = trimsuffix(local.domain, ".")

  zone_id = data.aws_route53_zone.this[0].zone_id

  tags = {
    Terraform   = "true"
    Environment = "dev"
    cost-center = ""
  }
}

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name = local.domain
  zone_id     = local.zone_id

  validation_method = "DNS"

  subject_alternative_names = [
     "*.sol.adorsys.com",
     "*.*.sol.adorsys.com",
     "*.*.*.sol.adorsys.com"
  ]

  wait_for_validation = true

  tags = {
    Name = "*.sol.adorsys.com",
    cost-center = ""
  }
}

data "aws_route53_zone" "this" {
  count = local.use_existing_route53_zone ? 1 : 0

  name         = local.domain_name
  private_zone = false
}
