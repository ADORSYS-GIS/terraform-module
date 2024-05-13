# Terraform Root

module "ssm" {
  source               = "./ssm"
  git-pull-token       = var.git-pull-token
  gitlab-registry-user = var.gitlab-registry-user
  gitlab-registry-pw   = var.gitlab-registry-pw
}

module "vpc" {
  source = "./vpc"
}

module "route53" {
  source       = "./route53"
  alb_dns_name = module.alb.dns_name
  alb_zone_id  = module.alb.zone_id
}

module "acm" {
  source = "./acm"

}

module "ec2-dev" {
  source = "./ec2-dev"

  vpc_id                   = module.vpc.vpc_id
  subnet_id                = element(module.vpc.private_subnets, 0)
  source_security_group_id = module.alb.security_group_id

}
module "ec2-support" {
  source = "./ec2-support"

  vpc_id                   = module.vpc.vpc_id
  subnet_id                = element(module.vpc.private_subnets, 0)
  source_security_group_id = module.alb.security_group_id

}

module "alb" {
  source          = "./alb"
  vpc_id          = module.vpc.vpc_id
  ec2_dev_id      = module.ec2-dev.ec2_dev_id
  ec2_support_id  = module.ec2-support.ec2_support_id
  cidr_ipv4       = module.vpc.vpc_cidr_block
  subnets         = module.vpc.public_subnets
  certificate_arn = module.acm.acm_certificate_arn
}
