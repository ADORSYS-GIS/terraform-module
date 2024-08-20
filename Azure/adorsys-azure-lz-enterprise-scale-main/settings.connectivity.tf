# Configure the connectivity resources settings.
locals {
  configure_connectivity_resources = {
    settings = {
      hub_networks = [
        {
          enabled = false
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
        enabled = true
        config = {
          location = null
          enable_private_link_by_service = {
            azure_api_management                 = false
            azure_app_configuration_stores       = false
            azure_arc                            = false
            azure_automation_dscandhybridworker  = false
            azure_automation_webhook             = false
            azure_backup                         = false
            azure_batch_account                  = false
            azure_bot_service_bot                = false
            azure_bot_service_token              = false
            azure_cache_for_redis                = false
            azure_cache_for_redis_enterprise     = false
            azure_container_registry             = false
            azure_cosmos_db_cassandra            = false
            azure_cosmos_db_gremlin              = false
            azure_cosmos_db_mongodb              = false
            azure_cosmos_db_sql                  = false
            azure_cosmos_db_table                = false
            azure_data_explorer                  = false
            azure_data_factory                   = false
            azure_data_factory_portal            = false
            azure_data_health_data_services      = false
            azure_data_lake_file_system_gen2     = false
            azure_database_for_mariadb_server    = false
            azure_database_for_mysql_server      = false
            azure_database_for_postgresql_server = false
            azure_digital_twins                  = false
            azure_event_grid_domain              = false
            azure_event_grid_topic               = false
            azure_event_hubs_namespace           = false
            azure_file_sync                      = false
            azure_hdinsights                     = false
            azure_iot_dps                        = false
            azure_iot_hub                        = false
            azure_key_vault                      = false
            azure_key_vault_managed_hsm          = false
            azure_kubernetes_service_management  = false
            azure_machine_learning_workspace     = false
            azure_managed_disks                  = false
            azure_media_services                 = false
            azure_migrate                        = false
            azure_monitor                        = false
            azure_purview_account                = false
            azure_purview_studio                 = false
            azure_relay_namespace                = false
            azure_search_service                 = false
            azure_service_bus_namespace          = false
            azure_site_recovery                  = false
            azure_sql_database_sqlserver         = false
            azure_synapse_analytics_dev          = false
            azure_synapse_analytics_sql          = false
            azure_synapse_studio                 = false
            azure_web_apps_sites                 = false
            azure_web_apps_static_sites          = false
            cognitive_services_account           = false
            microsoft_power_bi                   = false
            signalr                              = false
            signalr_webpubsub                    = false
            storage_account_blob                 = false
            storage_account_file                 = false
            storage_account_queue                = false
            storage_account_table                = false
            storage_account_web                  = false
          }
          private_link_locations = [
            "northeurope",
            "westeurope",
            "germanywestcentral",
          ]
          public_dns_zones                                       = [ "az.adorsys.com" ]
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
      custom_settings_by_resource_type = {
      #   # Resource group naming definition
        azurerm_resource_group = {
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
          "dns" = {
            "${var.connectivity_resources_location}" = {
              name = "rg-hub-dns"
            }
          }
        }

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
      }
    }
  }
}
