provider "aws" {
  region = var.region
}

locals {
  name            = "eks-${replace(var.eks_cluster_name, "_", "-")}"
  oidc_issuer_url = module.eks.cluster_oidc_issuer_url
  oidc_arn        = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(local.oidc_issuer_url, "https://", "")}"
  common_tags = {
    ClusterName = local.name
    cost-enter  = var.cost_center
    GithubRepo  = "https://github.com/ADORSYS-GIS/terraform-module"
  }
}

data "aws_iam_role" "admins" {
  name = var.sso_role_name.admins
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name

  depends_on = [module.eks]
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}