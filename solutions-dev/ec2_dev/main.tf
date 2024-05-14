locals {
   project = "Solutions"
   # ami-0a475f1dc65aa4221 - ubuntu 20.04 LTS - amd64 - eu-central-1 
   ami_id = data.aws_ami.ubuntu.id
   # 4 vCPU's 16 GB Ram x86_64
   instance_type           = "m6a.xlarge"
   vpc_security_group_ids = [module.ec2_security_group.security_group_id]
   subnet_id               = var.subnet_id
   volume_size             = 100
    
   user_data = <<-EOT
     #!/bin/bash
     apt-get install -y apt-transport-https ca-certificates curl software-properties-common
     curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
     add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
     apt-cache policy docker-ce
     apt-get install -y docker-ce
     curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
     chmod +x /usr/local/bin/docker-compose
     curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
     apt-get install unzip -y
     unzip awscliv2.zip
     ./aws/install

     echo "export TOKEN=$(aws ssm get-parameter --name "git-pull-token" --query "Parameter.Value" --with-decryption --output text)" >> $HOME/.bashrc
     echo "export GITLABUSER=$(aws ssm get-parameter --name "gitlab-registry-user" --query "Parameter.Value" --with-decryption --output text)" >> $HOME/.bashrc
     echo "export GITLABPW=$(aws ssm get-parameter --name "gitlab-registry-pw" --query "Parameter.Value" --with-decryption --output text)" >> $HOME/.bashrc
     source $HOME/.bashrc


     git clone https://groupaccesstoken:$TOKEN@git.adorsys.de/solutions/docker-develop

     echo "$GITLABPW" | docker login gitlab-registry.adorsys.de --username "$GITLABUSER" --password-stdin

     cd /docker-develop/develop/xs2a && docker-compose -p xs2a up -d
     cd /docker-develop/develop/modelbank && docker-compose -p modelbank up -d
     cd /docker-develop/develop/qwac-assessor && docker-compose -p qwac-assessor up -d
     cd /docker-develop/develop/traefik && docker-compose up -d
     cd /docker-develop/develop/watchtower && docker-compose up -d
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
  name                        = "${local.project}-dev-instance"
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

  name        = "sol-${local.project}"
  description = "Security group http-80/8080-tcp for EC2 instance"
  vpc_id      = var.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = var.source_security_group_id
    },
    {
      rule                     = "http-8080-tcp"
      source_security_group_id = var.source_security_group_id
    }
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
# TODO: Switch
# aws ubuntu comes with docker and aws cli 
  owners = ["099720109477"]
}

