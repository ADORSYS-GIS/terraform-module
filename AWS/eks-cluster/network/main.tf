module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-${var.vpc_name}"
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = [for i, zone in var.availability_zones : cidrsubnet(var.vpc_cidr, 8, i + length(var.availability_zones))]
  public_subnets  = [for i, zone in var.availability_zones : cidrsubnet(var.vpc_cidr, 8, i)]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_vpn_gateway = false

  default_security_group_name = "${var.vpc_name}-sg"

  tags = merge(
    {
      "kubernetes.io/cluster/${var.vpc_name}" = "shared"
    },
    var.common_tags,
  )

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}
