output "vpc_id" {
  value       = module.network.vpc.id
  description = "ID de la VPC creada"
}

output "public_subnet_a_id" {
  value       = module.network.public_subnet_a.id
  description = "ID de la subnet pública A"
}
