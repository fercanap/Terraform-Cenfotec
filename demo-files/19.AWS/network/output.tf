output "vpc" {
  value = aws_vpc.vpc
}

output "public_subnet_a" {
  value = aws_subnet.public_subnet_a
}

output "public_subnet_b" {
  value = aws_subnet.public_subnet_b
}

output "private_subnet" {
  value = aws_subnet.private_subnet
}

output "igw" {
  value = aws_internet_gateway.igw
}
