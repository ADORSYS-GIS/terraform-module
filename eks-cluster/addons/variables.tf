variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "cluster_name" {
  description = "Cluster name"
  type        = string
}
variable "cluster_endpoint" {
  description = "Cluster endpoint"
  type        = string
}
variable "cluster_version" {
  description = "Cluster version"
  type        = string
}
variable "oidc_provider_arn" {
  description = "OIDC provider ARN"
  type        = string
}

variable "common_tags" {}