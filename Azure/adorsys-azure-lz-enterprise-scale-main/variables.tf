# Use variables to customize the deployment

##############################
# global
##############################
variable "root_id" {
  type = string
}

variable "root_name" {
  type = string
}

variable "default_location" {
  type = string
}

variable "allowed_locations" {
  type = list(any)
}

##############################
# management resources
##############################
variable "deploy_management_resources" {
  type    = bool
  default = false
}

variable "log_retention_in_days" {
  type    = number
  default = 50
}

variable "security_alerts_email_address" {
  type    = string
  default = "my_valid_security_contact@replace_me" # Replace this value with your own email address.
}

variable "management_resources_location" {
  type    = string
  default = "westeurope"
}

variable "management_resources_tags" {
  type = map(string)
  default = {
    # demo_type = "deploy_management_resources_custom"
    deployment_mode = "IaC-Terraform"
  }
}

variable "management_subscription_id" {
  type        = string
  description = "If specified, identifies the Platform subscription for \"Management\" for resource deployment and correct placement in the Management Group hierarchy."
  default     = ""

  validation {
    condition     = can(regex("^[a-z0-9-]{36}$", var.management_subscription_id)) || var.management_subscription_id == ""
    error_message = "Value must be a valid Subscription ID (GUID)."
  }
}

variable "existing_log_analytics_workspace" {
  type        = string
  description = "If specified, module will skip creation of Log Analytics workspace and use existing."
  default     = ""
}

##############################
# connectivity resources
##############################
variable "deploy_connectivity_resources" {
  type    = bool
  default = false
}

variable "connectivity_resources_location" {
  type    = string
  default = "westeurope"
}

variable "connectivity_resources_tags" {
  type = map(string)
  default = {
    # demo_type = "deploy_connectivity_resources_custom"
    deployment_mode = "IaC-Terraform"
  }
}

variable "connectivity_subscription_id" {
  type        = string
  description = "If specified, identifies the Platform subscription for \"Connectivity\" for resource deployment and correct placement in the Management Group hierarchy."
  default     = ""

  validation {
    condition     = can(regex("^[a-z0-9-]{36}$", var.connectivity_subscription_id)) || var.connectivity_subscription_id == ""
    error_message = "Value must be a valid Subscription ID (GUID)."
  }
}

variable "subscription_id_overrides" {
  type = map(list(string))
  default = {
    # "management" = ["00000000-0000-0000-0000-000000000000"]
  }
}