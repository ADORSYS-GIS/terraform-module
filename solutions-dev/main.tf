# Terraform Root


module "vpc" {
  source = "./vpc"
}

module "route53" {
  source = "./route53"
  alb_dns_name = module.alb.dns_name
}

module "acm" {
  source = "./acm"

}

module "ec2" {
  source = "./ec2"

  vpc_id = module.vpc.vpc_id
  subnet_id = element(module.vpc.private_subnets, 0)
  source_security_group_id = module.alb.security_group_id

}

module "alb" {
  source = "./alb"
  vpc_id = module.vpc.vpc_id
  cidr_ipv4   = module.vpc.vpc_cidr_block
  subnets = module.vpc.public_subnets
  certificate_arn = module.acm.acm_certificate_arn
}
