locals {
  tags = {
    Terraform   = true,
    Environment = "dev",
    cost-center = ""
  }
  parameters = {
    "git-pull-token" = {
      type  = "SecureString"
      value = var.git-pull-token
    }
    "gitlab-registry-user" = {
      type  = "SecureString"
      value = var.gitlab-registry-user
    }
    "gitlab-registry-pw" = {
      type  = "SecureString"
      value = var.gitlab-registry-pw
    }
  }
}

module "ssm" {
  source  = "terraform-aws-modules/ssm-parameter/aws"
  version = "~> 1.0"

  for_each = local.parameters

  name  = try(each.value.name, each.key)
  value = try(each.value.value, null)
  type  = try(each.value.type, null)

  tags = local.tags
}
