locals {

  domain = "sol.adorsys.com"

  # Removing trailing dot from domain - just to be sure :)
  domain_name = trimsuffix(local.domain, ".")

  # Check if Zone is already created
  create_zone = data.aws_route53_zone.existing.zone_id ? 1 : 0

  tags = {
    Terraform   = "true",
    Environment = "dev",
    cost-center = ""
  }

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
      tags = local.tags
    }
  }
    tags = local.tags
}

 module "records" {
   source  = "terraform-aws-modules/route53/aws//modules/records"
   version = "~> 2.0"
 
   zone_name = keys(module.zones.route53_zone_zone_id)[0]
 
   records = [
     {
       name    = "*.sol.adorsys.com"
       type    = "A"
       alias   = {
         name    = var.alb_dns_name
         zone_id = module.zones.route53_zone_zone_id
       }
     }
   ]
 
   tags = local.tags

   depends_on = [module.zones]
 }
