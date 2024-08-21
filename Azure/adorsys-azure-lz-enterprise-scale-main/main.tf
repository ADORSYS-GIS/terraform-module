# Configure Terraform to set the required AzureRM provider
# version and features{} block.

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.114.0"
      configuration_aliases = [
        azurerm.connectivity,
        azurerm.management,
      ]
    }
  }
  # backend "azurerm" {
  #   resource_group_name  = "rg-terraform-prd-northeu-001"
  #   storage_account_name = "sttfstateconprd001"
  #   container_name       = "alz-es-tfstate"
  #   key                  = "alz-es-terraform.tfstate"
  # }
}

provider "azurerm" {
  features {}
}
provider "azurerm" {
  alias           = "management"
  subscription_id = var.management_subscription_id
  features {}
}

provider "azurerm" {
  alias           = "connectivity"
  subscription_id = var.connectivity_subscription_id
  features {}
}

# Get the current client configuration from the AzureRM provider.
# This is used to populate the root_parent_id variable with the
# current Tenant ID used as the ID for the "Tenant Root Group"
# management group.

# data "azurerm_client_config" "current" {}
data "azurerm_client_config" "current" {}

# Declare the Azure landing zones Terraform module
# and provide a base configuration.

module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "6.0.0"

  default_location = var.default_location

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm.connectivity
    azurerm.management   = azurerm.management
  }

  root_parent_id                  = data.azurerm_client_config.current.tenant_id
  root_id                         = var.root_id
  root_name                       = var.root_name
  library_path                    = "${path.root}/lib"
  strict_subscription_association = false

  ##################################################
  ## management deployment - cloudpunks
  ##################################################
  deploy_management_resources    = true
  subscription_id_management     = var.management_subscription_id
  configure_management_resources = local.configure_management_resources

  ##################################################
  ## connectivity deployment - cloudpunks
  ##################################################
  deploy_connectivity_resources    = true
  subscription_id_connectivity     = var.connectivity_subscription_id
  configure_connectivity_resources = local.configure_connectivity_resources

  ##################################################
  ## We have to define the core Landing Zones ourselves to prevent some
  ## of the management groups from being created.
  ##################################################
  deploy_core_landing_zones   = true
  deploy_corp_landing_zones   = true
  deploy_online_landing_zones = true

  archetype_config_overrides = local.archetype_config_overrides

  ##################################################
  ## Custom Landing Zones
  ###################################################
  # custom_landing_zones = {
  #   "galacticgekko-landingzone-prod" = {
  #     display_name               = "GalacticGekko LandingZone Prod"
  #     parent_management_group_id = "${var.root_id}-landing-zones"
  #     subscription_ids           = []
  #     archetype_config = {
  #       archetype_id   = "landingzone-prod"
  #       parameters     = {}
  #       access_control = {}
  #     }
  #   }

  #   "galacticgekko-landingzone-dev" = {
  #     display_name               = "GalacticGekko LandingZone Dev"
  #     parent_management_group_id = "${var.root_id}-landing-zones"
  #     subscription_ids           = []
  #     archetype_config = {
  #       archetype_id   = "landingzone-dev"
  #       parameters     = {}
  #       access_control = {}
  #     }
  #   }
  #   "galacticgekko-landingzone-qas" = {
  #     display_name               = "GalacticGekko LandingZone QAS"
  #     parent_management_group_id = "${var.root_id}-landing-zones"
  #     subscription_ids           = []
  #     archetype_config = {
  #       archetype_id   = "landingzone-qas"
  #       parameters     = {}
  #       access_control = {}
  #     }
  #   }
  #   "galacticgekko-landingzone-workload-infrastructure" = {
  #     display_name               = "GalacticGekko LandingZone Workload Infrastructure"
  #     parent_management_group_id = "${var.root_id}-landing-zones"
  #     subscription_ids           = []
  #     archetype_config = {
  #       archetype_id   = "landingzone-workload-infrastructure"
  #       parameters     = {}
  #       access_control = {}
  #     }
  #   }
  # }
}
