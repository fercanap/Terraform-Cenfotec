output "vpc_id" {
  value       = module.network.vpc.id
  description = "ID de la VPC creada"
}

output "public_subnet_a_id" {
  value       = module.network.public_subnet_a.id
  description = "ID de la subnet pública A"
}

output "bastion_ssh_command" {
  description = "Comando SSH para conectarse al Bastion Host"
  value       = "ssh -i key.pem ubuntu@${module.ec2.bastion_public_ip}"
}
