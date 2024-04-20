data "aws_caller_identity" "current" {}

module "vpc" {
  source = "./network"

  vpc_name           = local.name
  availability_zones = var.azs
  vpc_cidr           = var.eks_vpc_cidr

  common_tags        = local.common_tags
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = local.name
  cluster_version = var.kubernetes_version

  cluster_endpoint_public_access = true
  enable_efa_support             = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids

  node_security_group_name = "node-${var.eks_cluster_name}-sg"
  iam_role_name            = "${var.eks_cluster_name}-role"

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    instance_types = var.eks_instance_types
  }

  eks_managed_node_groups = {
    default_node_group = {
      name           = var.eks_cluster_name
      min_size       = var.eks_min_nodes
      max_size       = var.eks_max_nodes
      desired_size   = var.eks_desired_nodes
      disk_size      = var.eks_disk_size
      instance_types = var.eks_instance_types

      capacity_type  = var.capacity_type
    }
  }

  enable_cluster_creator_admin_permissions = var.enable_creator_admin_permissions

  access_entries = {
    eks-admins = {
      kubernetes_groups = ["devops"]
      principal_arn     = data.aws_iam_role.admins.arn

      policy_associations = {
        single = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  tags = merge(
    {
      "kubernetes.io/cluster-service" = "true"
    },
    local.common_tags,
  )
}
