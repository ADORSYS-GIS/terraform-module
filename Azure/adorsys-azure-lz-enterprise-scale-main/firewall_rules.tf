# resource "azurerm_firewall_policy_rule_collection_group" "base_policy_deny_all" {
#   name               = "afwrg-hub-prd-we-001"
#   firewall_policy_id = "/subscriptions/6e9fd544-fa24-44fc-81a7-f52e3e654936/resourceGroups/rg-hub-connectivity-prd-we-001/providers/Microsoft.Network/firewallPolicies/afwp-hub-connectivity-prd-we-001"
#   priority           = 500
#   application_rule_collection {
#     name     = "afwrc-hub-app-prd-we-001"
#     priority = 500
#     action   = "Deny"
#     rule {
#       name = "Deny_All_Apps"
#       protocols {
#         type = "Http"
#         port = 80
#       }
#       protocols {
#         type = "Https"
#         port = 443
#       }
#       source_addresses  = ["*"]
#       destination_fqdns = ["*"]
#     }
#   }

#   network_rule_collection {
#     name     = "afwrc-hub-net-prd-we-001"
#     priority = 400
#     action   = "Deny"
#     rule {
#       name                  = "Deny_All_Networks"
#       protocols             = ["Any"]
#       source_addresses      = ["*"]
#       destination_addresses = ["*"]
#       destination_ports     = ["*"]
#     }
#   }

#   network_rule_collection {
#     name     = "afwrc-hub-net-prd-we-002"
#     priority = 300
#     action   = "Allow"
#     rule {
#       name                  = "Allow_ICMP_Ping_All_Networks"
#       protocols             = ["ICMP"]
#       source_addresses      = ["*"]
#       destination_addresses = ["*"]
#       destination_ports     = ["*"]
#     }
#   }

#   #  nat_rule_collection {
#   #    name     = "nat_rule_collection1"
#   #    priority = 300
#   #    action   = "Dnat"
#   #    rule {
#   #      name                = "nat_rule_collection1_rule1"
#   #      protocols           = ["TCP", "UDP"]
#   #      source_addresses    = ["10.0.0.1", "10.0.0.2"]
#   #      destination_address = "192.168.1.1"
#   #      destination_ports   = ["80"]
#   #      translated_address  = "192.168.0.1"
#   #      translated_port     = "8080"
#   #    }
#   #  }
# }