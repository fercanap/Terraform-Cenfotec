resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = "VPC ${var.lab_name}"
  }
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id      = aws_vpc.vpc.id
  cidr_block  = var.public_cidr_block_a
	availability_zone = var.public_zone_a
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id      = aws_vpc.vpc.id
  cidr_block  = var.public_cidr_block_b
	availability_zone = var.public_zone_b
}

resource "aws_subnet" "private_subnet" {
  vpc_id      = aws_vpc.vpc.id
  cidr_block  = var.private_cidr_block
	availability_zone = var.private_zone
}
