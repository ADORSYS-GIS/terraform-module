module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  ami                  = var.deployment_models[var.deployment_model].ami_id
  name                 = "${var.project}-${var.deployment_models[var.deployment_model].name}"
  instance_type        = var.deployment_models[var.deployment_model].instance_type
  monitoring           = var.deployment_models[var.deployment_model].monitoring
  #vpc_security_group_ids = var.deployment_models[var.deployment_model].vpc_security_group_ids
  #subnet_id            = var.deployment_models[var.deployment_model].subnet_id
  tags                 = var.deployment_models[var.deployment_model].tags

  create_spot_instance = var.deployment_models[var.deployment_model].create_spot_instance
  spot_price           = var.deployment_models[var.deployment_model].spot_price
  spot_type            = var.deployment_models[var.deployment_model].spot_type

  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  enable_volume_tags = false
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 50
      tags = {
        Name = "${var.project}-ec2root-block"
      }
    },
  ]

  ebs_block_device = [
    {
      device_name = "/dev/sdf"
      volume_type = "gp3"
      volume_size = var.ebs_volume_size
      throughput  = 200
      encrypted   = true
      tags = {
        MountPoint = "/mnt/data"
      }
    }
  ]
}
