locals {

  domain = "sol.adorsys.com"

  # Removing trailing dot from domain - just to be sure :)
  domain_name = trimsuffix(local.domain, ".")

  # Check if Zone is already created
  create_zone = data.aws_route53_zone.existing.zone_id ? 1 : 0

}

data "aws_route53_zone" "existing" {
  name         = local.domain_name
  private_zone = false
}

module "zones" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "~> 2.0"

  count = local.create_zone ? 1 : 0

  zones = {
    "sol.adorsys.com" = {
      comment = "dev domain for solutions"
      tags = {
        Environment = "dev"
      }
    }
  }

  tags = {
    Terraform   = "true",
    Environment = "dev",
    cost-center = ""
  }
}

# module "records" {
#   source  = "terraform-aws-modules/route53/aws//modules/records"
#   version = "~> 2.0"
# 
#   zone_name = keys(module.zones.route53_zone_zone_id)[0]
# 
#   records = [
#     {
#       name    = "testname"
#       type    = "A"
#       alias   = {
#         name    = "d-10qxlbvagl.execute-api.eu-west-1.amazonaws.com"
#         zone_id = "ZLY8HYME6SFAD"
#       }
#     }
#   ]
# 
#   depends_on = [module.zones]
# }
