locals {
  project = "Solutions"

  tags = {
    Terraform   = "true"
    Environment = "dev"
    cost-center = ""
  }

}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 9.0"

  name    = "${local.project}-alb"
  vpc_id  = var.vpc_id
  subnets = var.subnets

  security_group_name = "alb-sg"
  # Security Group
  security_group_ingress_rules = {
    all_http = {
      from_port        = 80
      to_port          = 80
      ip_protocol      = "tcp"
      description      = "HTTP web traffic"
      cidr_ipv4        = "0.0.0.0/0"
      ipv6_cidr_blocks = ["::/0"]
    }
    all_https = {
      from_port        = 443
      to_port          = 443
      ip_protocol      = "tcp"
      description      = "HTTPS web traffic"
      cidr_ipv4        = "0.0.0.0/0"
      ipv6_cidr_blocks = ["::/0"]
    }
  }
  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = var.cidr_ipv4
    }
  }

  listeners = {
    http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
    https = {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = var.certificate_arn

      forward = {
        target_group_key = "sol-instance"
      }
    }
  }

  target_groups = {
    sol-instance = {
      name_prefix = "sol-"
      protocol    = "HTTP"
      port        = 80
      target_type = "instance"
    }
  }

  tags = local.tags
}
