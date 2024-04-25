locals {
  project = "Solutions"
  # ami-0a475f1dc65aa4221 - ubuntu 20.04 LTS - amd64 - eu-central-1 
  ami_id = data.aws_ami.ubuntu.id
  # 4 vCPU's 16 GB Ram x86_64
  instance_type           = "m6a.xlarge"
  vpc_security_group_ids = [module.ec2_security_group.security_group_id]
  subnet_id               = var.subnet_id
  volume_size             = 100

# TODO: 
# check if docker-compose is actually running
# init git 
  user_data = <<-EOT
    #!/bin/bash
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
  EOT

  tags = {
    Terraform   = "true"
    Environment = "dev"
    cost-center = ""
  }
}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  ami                         = local.ami_id
  name                        = "${local.project}-single-instance"
  instance_type               = local.instance_type
  monitoring                  = true
  vpc_security_group_ids      = local.vpc_security_group_ids
  subnet_id                   = local.subnet_id
  tags                        = local.tags
  create_spot_instance        = false
  user_data_base64            = base64encode(local.user_data)
  user_data_replace_on_change = true

  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  enable_volume_tags = false
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = local.volume_size
      tags = {
        Name = "${local.project}-ec2root-block"
      }
    },
  ]
}

module "ec2_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "sg-${local.project}"
  description = "Security group http-80-tcp for EC2 instance"
  vpc_id      = var.vpc_id

  # intended to only allow http traffic from the alb sg
  ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = var.source_security_group_id
    },
  ]
  egress_rules            = ["all-all"]

  tags = local.tags
}


data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
    # TODO: 
    # this legit owner?
  owners = ["099720109477"]
}

# TODO: 
# - [ ] needed for aws session manager to work ??

#  module "vpc_endpoints" {
#    source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
#    version = "~> 5.0"
#  
#    vpc_id = module.vpc.vpc_id
#  
#    endpoints = { for service in toset(["ssm", "ssmmessages", "ec2messages"]) :
#      replace(service, ".", "_") =>
#      {
#        service             = service
#        subnet_ids          = module.vpc.intra_subnets
#        private_dns_enabled = true
#        tags                = { Name = "${local.name}-${service}" }
#      }
#    }
#  
#    create_security_group      = true
#    security_group_name_prefix = "${local.name}-vpc-endpoints-"
#    security_group_description = "VPC endpoint security group"
#    security_group_rules = {
#      ingress_https = {
#        description = "HTTPS from subnets"
#        cidr_blocks = module.vpc.intra_subnets_cidr_blocks
#      }
#    }
#  
#    tags = local.tags
#  }
