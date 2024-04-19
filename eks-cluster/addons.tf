module "blueprints_addons" {
  source = "./addons"

  cluster_name      = module.eks.cluster_name
  cluster_endpoint  = module.eks.cluster_endpoint
  cluster_version   = module.eks.cluster_version
  oidc_provider_arn = local.oidc_arn

  vpc_id      = module.vpc.vpc_id
  common_tags = local.common_tags


  depends_on = [module.vpc, module.eks]
}