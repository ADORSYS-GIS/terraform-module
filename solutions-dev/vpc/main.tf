data "aws_availability_zones" "available" {}

locals {
  name   = "Solutions"
  region = "eu-central-1"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Terraform   = true,
    Environment = "dev",
    cost-center = ""
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_ipv6                                   = true
  public_subnet_assign_ipv6_address_on_creation = true

  private_subnet_ipv6_prefixes = [0, 1, 2]
  public_subnet_ipv6_prefixes  = [3, 4, 5]

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = local.tags
}
