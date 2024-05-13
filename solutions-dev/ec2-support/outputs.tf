output "ubuntu_ami" {
  value = data.aws_ami.ubuntu
}

output "ec2_support_id" {
  description = "The ID of the support instance"
  #value       = module.ec2_instance
  value       = module.ec2_instance.id
  #value       = { for k,v in module.ec2_instance : k => v.id }
}
