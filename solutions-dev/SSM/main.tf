locals {

  tags = {
    Terraform   = true,
    Environment = "dev",
    cost-center = ""
  }
}

module "secret" {
  source  = "terraform-aws-modules/ssm-parameter/aws"

  name        = "git-pull-token"
    # from stack guardian tfvars
  value       = var.git-pull-token
  secure_type = true

  tags = local.tags
}

