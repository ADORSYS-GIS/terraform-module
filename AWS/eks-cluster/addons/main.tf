# https://github.com/aws-ia/terraform-aws-eks-blueprints-addons
module "eks_blueprints_addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "~> 1.0"

  cluster_name      = var.cluster_name
  cluster_endpoint  = var.cluster_endpoint
  cluster_version   = var.cluster_version
  oidc_provider_arn = var.oidc_provider_arn

  eks_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    aws-ebs-csi-driver = {
      most_recent              = true
      service_account_role_arn = module.ebs_csi_driver_irsa.iam_role_arn
    }
    vpc-cni = {
      most_recent    = true
      before_compute = true
      configuration_values = jsonencode({
        env = {
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET       = "1"
        }
      })
    }
  }

  enable_aws_load_balancer_controller = true
  aws_load_balancer_controller = {
    set = [
      {
        name  = "vpcId"
        value = var.vpc_id
      },
      {
        name  = "podDisruptionBudget.maxUnavailable"
        value = 1
      },
      {
        name  = "enableServiceMutatorWebhook"
        value = "false"
      },
      {
        name  = "podDisruptionBudget.maxUnavailable"
        value = 1
      },
      {
        name  = "resources.requests.cpu"
        value = "100m"
      },
      {
        name  = "resources.requests.memory"
        value = "128Mi"
      },
    ]
  }

  enable_metrics_server = true
  metrics_server = {
    name          = "metrics-server"
    chart_version = "3.10.0"
    repository    = "https://kubernetes-sigs.github.io/metrics-server/"
    namespace     = "kube-system"
    values        = [templatefile("${path.module}/files/metricserver-values.yaml", {})]
  }

  enable_aws_node_termination_handler = false
  aws_node_termination_handler = {
    name          = "aws-node-termination-handler"
    chart_version = "0.21.0"
    repository    = "https://aws.github.io/eks-charts"
    namespace     = "aws-node-termination-handler"
    values        = [templatefile("${path.module}/files/nodehandler-values.yaml", {})]
  }

  enable_cluster_autoscaler = true
  cluster_autoscaler = {
    name          = "cluster-autoscaler"
    chart_version = "9.29.0"
    repository    = "https://kubernetes.github.io/autoscaler"
    namespace     = "kube-system"
    values        = [templatefile("${path.module}/files/autoscaler-values.yaml", {})]
  }

  tags = merge(
    {},
    var.common_tags,
  )
}
