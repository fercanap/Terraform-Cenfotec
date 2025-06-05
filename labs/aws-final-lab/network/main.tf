resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = merge(var.tags, {
    Name = "vpc-${var.lab_name}"
  })
}

# Subnets públicas
resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_cidr_block_a
  availability_zone = var.public_zone_a

  tags = merge(var.tags, {
    Name = "public-subnet-a-${var.lab_name}"
  })
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_cidr_block_b
  availability_zone = var.public_zone_b

  tags = merge(var.tags, {
    Name = "public-subnet-b-${var.lab_name}"
  })
}

# Subnet privada
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_cidr_block
  availability_zone = var.private_zone

  tags = merge(var.tags, {
    Name = "private-subnet-${var.lab_name}"
  })
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(var.tags, {
    Name = "igw-${var.lab_name}"
  })
}

# Elastic IP para NAT
resource "aws_eip" "nat_elastic_ip" {
  vpc = true
}

# NAT Gateway
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat_elastic_ip.id
  subnet_id     = aws_subnet.public_subnet_a.id

  depends_on = [aws_internet_gateway.igw]

  tags = merge(var.tags, {
    Name = "nat-${var.lab_name}"
  })
}

# Tabla de rutas públicas
resource "aws_route_table" "rt_igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(var.tags, {
    Name = "rt-public-${var.lab_name}"
  })
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.rt_igw.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_subnet_association_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.rt_igw.id
}

resource "aws_route_table_association" "public_subnet_association_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.rt_igw.id
}

# Tabla de rutas privadas
resource "aws_route_table" "rt_nat" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(var.tags, {
    Name = "rt-private-${var.lab_name}"
  })
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.rt_nat.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw.id
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.rt_nat.id
}
