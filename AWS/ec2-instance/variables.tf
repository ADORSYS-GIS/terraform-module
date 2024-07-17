variable "deployment_models" {
  description = "Map of deployment configurations for EC2 instances"
  type = map(object({
    name                 = string
    ami_id               = string
    create_spot_instance = bool
    spot_price           = optional(string)
    spot_type            = optional(string)
    instance_type        = string
    monitoring           = bool
    #vpc_security_group_ids = list(string)
    #subnet_id            = string
    tags                 = map(string)
  }))

  default = {
    "single" = {
      name                 = "single-instance"
      ami_id               = "ami-0a475f1dc65aa4221"
      create_spot_instance = false
      instance_type        = "t2.large"
      monitoring           = true
      #vpc_security_group_ids = ["sg-0fc4a2c1b97e1b5b8"]
      #subnet_id            = "subnet-eddcdzz4"
      tags                 = { Terraform = "true", Environment = "dev" }
    },
    "spot" = {
      name                 = "spot-instance"
      ami_id               = "ami-0a475f1dc65aa4221"
      create_spot_instance = true
      spot_price           = "0.60"
      spot_type            = "persistent"
      instance_type        = "t2.micro"
      monitoring           = true
      #vpc_security_group_ids = ["sg-0fc4a2c1b97e1b5b8"]
      #subnet_id            = "subnet-eddcdzz4"
      tags                 = { Terraform = "true", Environment = "dev" }
    }
  }
}

variable "deployment_model" {
  description = "Deployment model to use"
  type = string
  default = "single"
}

variable "project" {
    description = "Name of the project"
    type = string
    default = "advk-dbvk"
}
variable "ebs_volume_size" {
  type = number
  default = 10
}