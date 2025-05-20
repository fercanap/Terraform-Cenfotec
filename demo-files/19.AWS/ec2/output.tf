output "bastion_public_ip" {
  value       = aws_instance.ec2Bastion.public_ip
}
