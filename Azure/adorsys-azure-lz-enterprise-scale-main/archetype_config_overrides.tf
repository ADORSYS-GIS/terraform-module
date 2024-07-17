locals {
  archetype_config_overrides = {
    # root = {
    #   enforcement_mode = {
    #     Enforce-ACSB           = false
    #     Deploy-VMSS-Monitoring = false
    #     Deploy-VM-Monitoring   = false
    #     Deploy-Resource-Diag   = false
    #     Deploy-MDFC-SqlAtp     = false
    #     Deploy-MDFC-OssDb      = false
    #     Deploy-MDFC-Config     = false
    #     Deploy-MDEndpoints     = false
    #     Deploy-AzActivity-Log  = false
    #     # Deploy-ASC-Monitoring   = false
    #     # Deny-UnmanagedDisk      = false 
    #     # Deny-Classic-Resources  = false
    #     # Audit-UnusedResource    = false
    #   }
    # }

    # landing-zones = {
    #   enforcement_mode = {
    #     Enforce-GR-KeyVault     = false
    #     Enable-DDoS-VNET        = false
    #     Deploy-SQL-TDE          = false
    #     Deny-Privileged-AKS     = false
    #     Enforce-AKS-HTTPS       = false
    #     Deploy-AzSqlDb-Auditing = false
    #     # Deny-IP-forwarding      = false
    #     Enforce-TLS-SSL = false
    #     # Deny-MgmtPorts-Internet = false
    #     Deploy-AKS-Policy = false
    #     # Deny-Storage-http       = false
    #     Deny-Subnet-Without-Nsg = false
    #     Deploy-SQL-Threat       = false
    #     # Audit-AppGW-WAF         = false
    #     # Deny-Priv-Esc-AKS       = false
    #   }
    # }
    # corp = {
    #   enforcement_mode = {
    #     #Deny-Public-Endpoints    = false
    #     #Deploy-Private-DNS-Zones = false
    #     #Deny-Public-IP-On-NIC    = false
    #     #Deny-HybridNetworking    = false
    #     #Audit-PeDnsZones         = false
    #   }
    # }
    # platform = {
    #   enforcement_mode = {
    #     #Enforce-GR-KeyVault      = false
    #   }
    # }
    # connectivity = {
    #   enforcement_mode = {
    #     #Enable-DDoS-VNET         = false
    #   }
    # }
    # identity = {
    #   enforcement_mode = {
    #     #Deny-Public-IP           = false
    #     #Deploy-VM-Backup         = false
    #     #Deny-Subnet-Without-Nsg  = false
    #     #Deny-MgmtPorts-Internet  = false
    #     #Deploy-Log-Analytics     = false
    #   }
    # }
  }
}