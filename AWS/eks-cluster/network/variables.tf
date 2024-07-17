variable "vpc_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "vpc_cidr" {
  description = "CIDR for the EKS cluster"
  type        = string
}

variable "common_tags" {
  type = object({
    ClusterName : string,
    cost-enter : string,
  })
}
