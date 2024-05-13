output "ubuntu_ami" {
  value = data.aws_ami.ubuntu
}

output "ec2_dev_id" {
  description = "The ID of the dev instance"
  #value       = module.ec2_instance
  value       = module.ec2_instance.id
  #value       = { for k,v in module.ec2_instance : k => v.id }
}
