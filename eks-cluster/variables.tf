variable "region" {}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-cluster"
}

variable "eks_vpc_cidr" {
  description = "CIDR for the EKS cluster"
  type        = string
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "eks_instance_types" {
  description = "List of EC2 instance types"
  type        = list(string)
  default     = ["t2.xlarge"]
}

variable "eks_disk_size" {
  description = "Size of the instance disk size"
  type        = number
  default     = 50
}

variable "eks_desired_nodes" {
  description = "Desired number of nodes in the EKS node group"
  type        = number
  default     = 2
}

variable "eks_min_nodes" {
  description = "Minimum number of nodes in the EKS node group"
  type        = number
  default     = 1
}

variable "eks_max_nodes" {
  description = "Maximum number of nodes in the EKS node group"
  type        = number
  default     = 6
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.29"
}

variable "capacity_type" {
  description = "Capacity type for the EKS node group"
  type        = string
  default     = "SPOT"
}

variable "cost_center" {
  description = "Cost center"
  type        = string
  default     = "shared"
}

variable "sso_role_name" {
  description = "SSO role"
  type        = map(string)
  default = {
    "admins" = "AWSReservedSSO_AdministratorAccess"
  }
}