locals {

  tags = {
    Terraform   = true,
    Environment = "dev",
    cost-center = ""
  }
}

module "ssm" {
  source  = "terraform-aws-modules/ssm-parameter/aws"
  version = "~> 1.0"

  name        = "git-pull-token"
  value       = var.value
  secure_type = true

  tags = local.tags
}

