# Configure the connectivity resources settings.
locals {
  configure_connectivity_resources = {
    settings = {
      hub_networks = [
        {
          enabled = true
          config = {
            address_space                = ["10.210.0.0/20", ]
            location                     = var.default_location
            link_to_ddos_protection_plan = false
            dns_servers                  = []
            bgp_community                = ""
            subnets = [
              # {
              #     name                      = "mysubnet"
              #     address_prefixes          = ["10.100.10.0/24"]
              #     network_security_group_id = ""
              #     route_table_id            = ""
              # }
            ]
            virtual_network_gateway = {
              enabled = true
              config = {
                address_prefix           = "10.210.1.0/24"
                gateway_sku_expressroute = ""
                gateway_sku_vpn          = "VpnGw1"
                advanced_vpn_settings = {
                  enable_bgp                       = null
                  active_active                    = null
                  private_ip_address_allocation    = ""
                  default_local_network_gateway_id = ""
                  vpn_client_configuration         = []
                  bgp_settings                     = []
                  custom_route                     = []
                }
              }
            }
            azure_firewall = {
              enabled = false
              config = {
                address_prefix                = "10.210.0.0/24"
                enable_dns_proxy              = true
                dns_servers                   = []
                sku_tier                      = ""
                base_policy_id                = ""
                private_ip_ranges             = []
                threat_intelligence_mode      = ""
                threat_intelligence_allowlist = {}
                availability_zones = {
                  zone_1 = true
                  zone_2 = true
                  zone_3 = true
                }
              }
            }
            spoke_virtual_network_resource_ids      = []
            enable_outbound_virtual_network_peering = true
            enable_hub_network_mesh_peering         = false
          }
        },
        # {
        #   enabled = true
        #   config = {
        #     address_space                = ["10.211.0.0/20", ]
        #     location                     = "westeurope"
        #     link_to_ddos_protection_plan = false
        #     dns_servers                  = []
        #     bgp_community                = ""
        #     subnets                      = []
        #     virtual_network_gateway = {
        #       enabled = true
        #       config = {
        #         address_prefix           = "10.211.1.0/24"
        #         gateway_sku_expressroute = ""
        #         gateway_sku_vpn          = "VpnGw2AZ"
        #         advanced_vpn_settings = {
        #           enable_bgp                       = true
        #           active_active                    = true
        #           private_ip_address_allocation    = ""
        #           default_local_network_gateway_id = ""
        #           vpn_client_configuration         = []
        #           bgp_settings = [
        #             {
        #               asn = "65515"
        #               peering_addresses = [
        #                 { apipa_addresses = ["169.254.21.6"] },
        #                 { apipa_addresses = ["169.254.21.2"] }
        #               ]
        #             }
        #           ]
        #           custom_route = []
        #         }
        #       }
        #     }
        #     azure_firewall = {
        #       enabled = true
        #       config = {
        #         address_prefix                = "10.211.0.0/24"
        #         enable_dns_proxy              = true
        #         dns_servers                   = []
        #         sku_tier                      = "Standard"
        #         base_policy_id                = ""
        #         private_ip_ranges             = []
        #         threat_intelligence_mode      = ""
        #         threat_intelligence_allowlist = {}
        #         availability_zones = {
        #           zone_1 = true
        #           zone_2 = true
        #           zone_3 = false
        #         }
        #       }
        #     }
        #     spoke_virtual_network_resource_ids = [
        #       "/subscriptions/bd4ef732-ebf0-4416-bea1-45c02056fa5f/resourceGroups/srm-qas/providers/Microsoft.Network/virtualNetworks/qas-cluster-vnet",
        #       "/subscriptions/bd4ef732-ebf0-4416-bea1-45c02056fa5f/resourceGroups/srm-platform/providers/Microsoft.Network/virtualNetworks/platform-cluster-vnet"
        #     ]
        #     enable_outbound_virtual_network_peering = true
        #     enable_hub_network_mesh_peering         = false
        #   }
        # },
      ]
      vwan_hub_networks = []
      ddos_protection_plan = {
        enabled = false
        config = {
          location = var.default_location
        }
      }
      dns = {
        enabled = false
        config = {
          location = null
          enable_private_link_by_service = {
            azure_api_management                 = true
            azure_app_configuration_stores       = true
            azure_arc                            = true
            azure_automation_dscandhybridworker  = true
            azure_automation_webhook             = true
            azure_backup                         = true
            azure_batch_account                  = true
            azure_bot_service_bot                = true
            azure_bot_service_token              = true
            azure_cache_for_redis                = true
            azure_cache_for_redis_enterprise     = true
            azure_container_registry             = true
            azure_cosmos_db_cassandra            = true
            azure_cosmos_db_gremlin              = true
            azure_cosmos_db_mongodb              = true
            azure_cosmos_db_sql                  = true
            azure_cosmos_db_table                = true
            azure_data_explorer                  = true
            azure_data_factory                   = true
            azure_data_factory_portal            = true
            azure_data_health_data_services      = true
            azure_data_lake_file_system_gen2     = true
            azure_database_for_mariadb_server    = true
            azure_database_for_mysql_server      = true
            azure_database_for_postgresql_server = true
            azure_digital_twins                  = true
            azure_event_grid_domain              = true
            azure_event_grid_topic               = true
            azure_event_hubs_namespace           = true
            azure_file_sync                      = true
            azure_hdinsights                     = true
            azure_iot_dps                        = true
            azure_iot_hub                        = true
            azure_key_vault                      = true
            azure_key_vault_managed_hsm          = true
            azure_kubernetes_service_management  = true
            azure_machine_learning_workspace     = true
            azure_managed_disks                  = true
            azure_media_services                 = true
            azure_migrate                        = true
            azure_monitor                        = true
            azure_purview_account                = true
            azure_purview_studio                 = true
            azure_relay_namespace                = true
            azure_search_service                 = true
            azure_service_bus_namespace          = true
            azure_site_recovery                  = true
            azure_sql_database_sqlserver         = true
            azure_synapse_analytics_dev          = true
            azure_synapse_analytics_sql          = true
            azure_synapse_studio                 = true
            azure_web_apps_sites                 = true
            azure_web_apps_static_sites          = true
            cognitive_services_account           = true
            microsoft_power_bi                   = true
            signalr                              = true
            signalr_webpubsub                    = true
            storage_account_blob                 = true
            storage_account_file                 = true
            storage_account_queue                = true
            storage_account_table                = true
            storage_account_web                  = true
          }
          private_link_locations = [
            "northeurope",
            "westeurope",
            "germanywestcentral",
          ]
          public_dns_zones                                       = []
          private_dns_zones                                      = []
          enable_private_dns_zone_virtual_network_link_on_hubs   = true
          enable_private_dns_zone_virtual_network_link_on_spokes = true
          virtual_network_resource_ids_to_link                   = []
        }
      }
    }

    location = var.connectivity_resources_location
    tags     = var.connectivity_resources_tags
    advanced = {
      # custom_settings_by_resource_type = {
      #   # Resource group naming definition
      #   azurerm_resource_group = {
      #     "connectivity" = {
      #       "${var.connectivity_resources_location}" = {
      #         name = "rg-hub-connectivity-northeu-prod"
      #       },
      #       "westeurope" = {
      #         name = "rg-hub-connectivity-prd-we-001"
      #       }
      #     },
      #     "virtual_wan" = {
      #       "${var.connectivity_resources_location}" = {
      #         name = "rg-hub-vwan-northeu-prod"
      #       },
      #       "westeurope" = {
      #         name = "rg-hub-vwan-prd-we-"
      #       }
      #     },
      #     "ddos" = {
      #       "${var.connectivity_resources_location}" = {
      #         name = "rg-hub-ddos-northeu-prod"
      #       },
      #       "westeurope" = {
      #         name = "rg-hub-ddos-prd-we-"
      #       }
      #     },
      #     "dns" = {
      #       "${var.connectivity_resources_location}" = {
      #         name = "rg-hub-dns"
      #       }
      #     }
      #   }

      #   # Connectivity naming definition - Virtual network
      #   azurerm_virtual_network = {
      #     "connectivity" = {
      #       "${var.connectivity_resources_location}" = {
      #         name = "vnet-hub-connectivity-northeu-prod-001"
      #       },
      #       "westeurope" = {
      #         name = "vnet-hub-connectivity-prd-we-001"
      #       }
      #     }
      #   }

      #   # Connectivity naming definition - Virtual WAN
      #   azurerm_virtual_wan = {
      #     "virtual_wan" = {
      #       "${var.connectivity_resources_location}" = {
      #         name = "vwan-connectivity-northeu-prod-001"
      #       },
      #       "westeurope" = {
      #         name = "vwan-connectivity-prd-we-001"
      #       }
      #     }
      #   }
      #   azurerm_virtual_hub = {
      #     "virtual_wan" = {
      #       "${var.connectivity_resources_location}" = {
      #         name = "vwan-hub-connectivity-northeu-prod-001"
      #       },
      #       "westeurope" = {
      #         name = "vwan-hub-connectivity-prd-we-001"
      #       }
      #     }
      #   }

      #   # Connectivity naming definition - Azure Firewall
      #   azurerm_firewall = {
      #     "connectivity" = {
      #       "${var.connectivity_resources_location}" = {
      #         name = "afw-hub-connectivity-northeu-prod-001"
      #       },
      #       "westeurope" = {
      #         name = "afw-hub-connectivity-prd-we-001"
      #       }
      #     }
      #     "virtual_wan" = {
      #       "${var.connectivity_resources_location}" = {
      #         name = "afw-vwan-connectivity-northeu-prod-001"
      #       },
      #       "westeurope" = {
      #         name = "afw-vwan-connectivity-prd-we-001"
      #       }
      #     }
      #   }
      #   azurerm_firewall_policy = {
      #     "connectivity" = {
      #       "${var.connectivity_resources_location}" = {
      #         name = "afwp-hub-connectivity-northeu-prod-001"
      #       },
      #       "westeurope" = {
      #         name = "afwp-hub-connectivity-prd-we-001"
      #       }
      #     }
      #     "virtual_wan" = {
      #       "${var.connectivity_resources_location}" = {
      #         name = "afwp-vwan-connectivity-northeu-prod-001"
      #       },
      #       "westeurope" = {
      #         name = "afwp-vwan-connectivity-prd-we-001"
      #       }
      #     }
      #   }

      #   # Connectivity naming definition - Public IPs
      #   azurerm_public_ip = {
      #     "connectivity_firewall" = {
      #       "${var.connectivity_resources_location}" = {
      #         name = "pip-connectivity-afw-northeu-prod-001"
      #       },
      #       "westeurope" = {
      #         name = "pip-connectivity-afw-prd-we-001"
      #       }
      #     }
      #     "connectivity_vpn" = {
      #       "${var.connectivity_resources_location}" = {
      #         name = "pip-connectivity-vpn-northeu-prod-001"
      #       },
      #       "westeurope" = {
      #         name = "pip-connectivity-vpn-prd-we-001"
      #       }
      #     }
      #     "connectivity_vpn_2" = {
      #       "${var.connectivity_resources_location}" = {
      #         name = "pip-connectivity-vpn-northeu-prod-002"
      #       },
      #       "westeurope" = {
      #         name = "pip-connectivity-vpn-prd-we-002"
      #       }
      #     }
      #     "connectivity_expressroute" = {
      #       "${var.connectivity_resources_location}" = {
      #         name = "vnet-connectivity-er-northeu-prod-001"
      #       },
      #       "westeurope" = {
      #         name = "vnet-connectivity-er-prd-we-001"
      #       }
      #     }
      #   }

      #   # Connectivity naming definition - vNet Gateways
      #   azurerm_virtual_network_gateway = {
      #     "connectivity_vpn" = {
      #       "${var.connectivity_resources_location}" = {
      #         name = "vgw-hub-connectivity-northeu-prod-001"
      #       },
      #       "westeurope" = {
      #         name = "vgw-hub-connectivity-prd-we-001"
      #       }
      #     }
      #     "connectivity_expressroute" = {
      #       "${var.connectivity_resources_location}" = {
      #         name = "er-hub-connectivity-northeu-prod-001"
      #       },
      #       "westeurope" = {
      #         name = "er-hub-connectivity-prd-we-001"
      #       }
      #     }
      #   }

      #   # # Connectivity naming definition - VPN Gateways
      #   # azurerm_vpn_gateway = {
      #   #   "connectivity" = {
      #   #     "${var.connectivity_resources_location}" = {
      #   #       name = "vgw-hub-connectivity-northeu-prod-001"
      #   #     }
      #   #   }
      #   #   "virtual_wan" = {
      #   #     "${var.connectivity_resources_location}" = {
      #   #       name = "vgw-vwan-connectivity-northeu-prod-001"
      #   #     }
      #   #   }
      #   # }

      #   # # Connectivity naming definition - Express Routes
      #   # azurerm_express_route_gateway = {
      #   #   "virtual_wan" = {
      #   #     "${var.connectivity_resources_location}" = {
      #   #       name = "erc-hub-connectivity-northeu-prod-001"
      #   #     }
      #   #   }
      #   # }
      # }
    }
  }
}
