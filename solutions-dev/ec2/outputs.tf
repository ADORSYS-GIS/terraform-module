output "ubuntu_ami" {
  value = data.aws_ami.ubuntu
}

output "ec2_complete_id" {
  description = "The ID of the instance"
  value       = module.ec2_instance.id
}
