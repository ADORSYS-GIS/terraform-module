# resource "azurerm_resource_group" "rg-management-keyvault-prd-we-001" {
#   provider = azurerm.management
#   name     = "rg-management-keyvault-prd-we-001"
#   location = "West Europe"
#   tags     = var.connectivity_resources_tags
# }

# resource "azurerm_key_vault" "kv-mgmt-prd-ES-we-001" {
#   provider                    = azurerm.management
#   name                        = "kv-mgmt-prd-ES-we-001"
#   location                    = azurerm_resource_group.rg-management-keyvault-prd-we-001.location
#   resource_group_name         = azurerm_resource_group.rg-management-keyvault-prd-we-001.name
#   enabled_for_disk_encryption = true
#   tenant_id                   = data.azurerm_client_config.current.tenant_id
#   soft_delete_retention_days  = 7
#   purge_protection_enabled    = true

#   sku_name = "standard"

#   # defined in separate access-policy objects
#   # access_policy = []
# }

# # ## keyvault access policies
# # resource "azurerm_key_vault_access_policy" "kv-policy-terraform-appreg" {
# #   provider = azurerm.management

# #   key_vault_id = azurerm_key_vault.kv-mgmt-prd-ES-we-001.id
# #   tenant_id    = data.azurerm_client_config.current.tenant_id
# #   object_id    = "3539a586-cb5e-4c40-ac46-8a8ddbe13f7a"
# #   key_permissions = [
# #     "Get",
# #   ]
# #   secret_permissions = [
# #     "Get",
# #   ]
# #   storage_permissions = [
# #     "Get",
# #   ]
# # }

# # resource "azurerm_key_vault_access_policy" "kv-policy-mstreb" {
# #   provider = azurerm.management

# #   key_vault_id = azurerm_key_vault.kv-mgmt-prd-ES-we-001.id
# #   tenant_id    = data.azurerm_client_config.current.tenant_id
# #   object_id    = "91c4ada8-2a09-4571-a92c-b4a56a1ffa1b"

# #   key_permissions = [
# #     "Get",
# #   ]
# #   secret_permissions = [
# #     "Get",
# #   ]
# #   storage_permissions = [
# #     "Get",
# #   ]
# # }