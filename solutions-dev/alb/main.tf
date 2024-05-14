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
  version = "9.7.1"
  #version = "~> 9"

  name    = "${local.project}-alb"
  vpc_id  = var.vpc_id
  subnets = var.subnets

  putin_khuylo = true
  enable_deletion_protection = false

  security_group_name = "alb-sg"
  # Security Group
  security_group_ingress_rules = {
    all_http = {
      from_port        = 80
      to_port          = 80
      ip_protocol      = "tcp"
      description      = "HTTP web traffic"
      cidr_ipv4        = "0.0.0.0/0"
      #ipv6_cidr_blocks = ["::/0"]
    }
    all_https = {
      from_port        = 443
      to_port          = 443
      ip_protocol      = "tcp"
      description      = "HTTPS web traffic"
      cidr_ipv4        = "0.0.0.0/0"
      #ipv6_cidr_blocks = ["::/0"]
    }
  }
  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = var.cidr_ipv4
    }
  }

  listeners = {

    http_https_redirect = {
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
      fixed_response = {
       status_code = "501"
       content_type = "text/plain"
       message_body = "No Path Found"
      }
      rules = {

        support = {
          actions = [{
            type = "forward"
            target_group_key = "support_instance"
          }]
          conditions = [{
            host_header = {
              values = ["*.support.sol.adorsys.com"] 
            }
          }]
        }

        dev = {
          actions = [{
            type = "forward"
            target_group_key = "dev_instance"
          }]
          conditions = [{
            host_header = {
              values = ["*.dev.sol.adorsys.com"] 
            }
          }]
        }

      }
    }
  }

  target_groups = {

    sol_instance = {
      name_prefix = "sol-"
      protocol    = "HTTP"
      port        = 80
      target_type = "instance"
 
      health_check = {
        enabled             = true
        healthy_threshold   = 5
        interval            = 30
        matcher             = "200"
        path                = "/ping"
        port                = "8080"
        protocol            = "HTTP"
        timeout             = 5
        unhealthy_threshold = 2
      }   

      protocol_version = "HTTP1"
      target_id        = "i-12345678"
      port             = 80
    }

    dev_instance = {
      name_prefix = "dev-"
      protocol    = "HTTP"
      port        = 80
      target_type = "instance"
 
      health_check = {
        enabled             = true
        healthy_threshold   = 5
        interval            = 30
        matcher             = "200"
        path                = "/ping"
        port                = "8080"
        protocol            = "HTTP"
        timeout             = 5
        unhealthy_threshold = 2
      }   

      protocol_version = "HTTP1"
      target_id        = var.ec2_dev_id
      port             = 80
    }

    support_instance = {
      name_prefix = "sup-"
      protocol    = "HTTP"
      port        = 80
      target_type = "instance"
 
      health_check = {
        enabled             = true
        healthy_threshold   = 5
        interval            = 30
        matcher             = "200"
        path                = "/ping"
        port                = "8080"
        protocol            = "HTTP"
        timeout             = 5
        unhealthy_threshold = 2
      }   

      protocol_version = "HTTP1"
      target_id        = var.ec2_support_id 
      port             = 80
    }


  }

  tags = local.tags
}
