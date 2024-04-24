


module "vpc" {
  source = "./vpc"
}
module "route53" {
  source = "./route53"
}
module "acm" {
  source = "./acm"
}
module "ec2" {
  source = "./ec2"
}
module "alb" {
  source = "./alb"
}
