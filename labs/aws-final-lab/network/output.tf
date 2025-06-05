output "vpc" {
  value       = aws_vpc.vpc
  description = "VPC principal"
}

output "public_subnet_a" {
  value       = aws_subnet.public_subnet_a
  description = "Subnet pública A"
}

output "public_subnet_b" {
  value       = aws_subnet.public_subnet_b
  description = "Subnet pública B"
}

output "private_subnet" {
  value       = aws_subnet.private_subnet
  description = "Subnet privada"
}
