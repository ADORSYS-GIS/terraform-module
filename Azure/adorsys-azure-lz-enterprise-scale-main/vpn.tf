# ###Local Network Gateway #1
# resource "azurerm_local_network_gateway" "lng-hub-connectivity-prd-partner1-we-001" {
#   name                = "lng-hub-connectivity-prd-partner1-we-001"
#   resource_group_name = "rg-hub-connectivity-prd-we-001"
#   location            = "westeurope"
#   gateway_address     = "185.170.24.128"
#   bgp_settings {
#     asn                 = "65000"
#     bgp_peering_address = "169.254.21.1"
#   }
#   tags = var.connectivity_resources_tags
# }


# ###Local Network Gateway #2
# resource "azurerm_local_network_gateway" "lng-hub-connectivity-prd-partner1-we-002" {
#   name                = "lng-hub-connectivity-prd-partner1-we-002"
#   resource_group_name = "rg-hub-connectivity-prd-we-001"
#   location            = "westeurope"
#   gateway_address     = "185.170.24.130"
#   bgp_settings {
#     asn                 = "65000"
#     bgp_peering_address = "169.254.21.5"
#   }
#   tags = var.connectivity_resources_tags
# }


# ### get VPN PSK from keyvault
# data "azurerm_key_vault_secret" "partner1-vpn-psk" {
#   name         = "partner1-vpn-psk"
#   key_vault_id = azurerm_key_vault.kv-mgmt-prd-ES-we-001.id
# }

# ### setup vpn connection
# resource "azurerm_virtual_network_gateway_connection" "lnc-hub-connectivity-prd-partner1-we-001" {
#   name                = "lnc-hub-connectivity-prd-partner1-we-001"
#   location            = "westeurope"
#   tags                = var.connectivity_resources_tags
#   resource_group_name = module.enterprise_scale.azurerm_resource_group.connectivity["/subscriptions/6e9fd544-fa24-44fc-81a7-f52e3e654936/resourceGroups/rg-hub-connectivity-prd-we-001"].name

#   type                       = "IPsec"
#   virtual_network_gateway_id = module.enterprise_scale.azurerm_virtual_network_gateway.connectivity["/subscriptions/6e9fd544-fa24-44fc-81a7-f52e3e654936/resourceGroups/rg-hub-connectivity-prd-we-001/providers/Microsoft.Network/virtualNetworkGateways/vgw-hub-connectivity-prd-we-001"].id
#   local_network_gateway_id   = azurerm_local_network_gateway.lng-hub-connectivity-prd-partner1-we-001.id

#   shared_key = data.azurerm_key_vault_secret.partner1-vpn-psk.value

#   connection_protocol = "IKEv2"
#   enable_bgp          = true
#   # custom_bgp_addresses {
#   #   primary = "169.254.21.2"
#   #   secondary = "169.254.21.6"
#   # }

#   ipsec_policy {
#     ike_encryption   = "AES256"
#     ike_integrity    = "SHA256"
#     dh_group         = "DHGroup14"
#     ipsec_encryption = "AES256"
#     ipsec_integrity  = "SHA256"
#     pfs_group        = "ECP384"
#     sa_lifetime      = 3600
#   }
# }

# resource "azurerm_virtual_network_gateway_connection" "lnc-hub-connectivity-prd-partner1-we-002" {
#   name                = "lnc-hub-connectivity-prd-partner1-we-002"
#   location            = "westeurope"
#   tags                = var.connectivity_resources_tags
#   resource_group_name = module.enterprise_scale.azurerm_resource_group.connectivity["/subscriptions/6e9fd544-fa24-44fc-81a7-f52e3e654936/resourceGroups/rg-hub-connectivity-prd-we-001"].name

#   type                       = "IPsec"
#   virtual_network_gateway_id = module.enterprise_scale.azurerm_virtual_network_gateway.connectivity["/subscriptions/6e9fd544-fa24-44fc-81a7-f52e3e654936/resourceGroups/rg-hub-connectivity-prd-we-001/providers/Microsoft.Network/virtualNetworkGateways/vgw-hub-connectivity-prd-we-001"].id
#   local_network_gateway_id   = azurerm_local_network_gateway.lng-hub-connectivity-prd-partner1-we-002.id

#   shared_key = data.azurerm_key_vault_secret.partner1-vpn-psk.value

#   connection_protocol = "IKEv2"
#   enable_bgp          = true
#   # custom_bgp_addresses {
#   #   primary = "169.254.21.6"
#   #   secondary = "169.254.21.2"
#   # }

#   ipsec_policy {
#     ike_encryption   = "AES256"
#     ike_integrity    = "SHA256"
#     dh_group         = "DHGroup14"
#     ipsec_encryption = "AES256"
#     ipsec_integrity  = "SHA256"
#     pfs_group        = "ECP384"
#     sa_lifetime      = 3600
#   }
# }