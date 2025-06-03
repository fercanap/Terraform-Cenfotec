resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "VPC ${terraform.workspace}"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id      = aws_vpc.vpc.id
  cidr_block  = "10.0.0.0/28"
}

resource "aws_instance" "server" {
  ami           = var.ami
  instance_type = "t3a.nano"
  subnet_id     = aws_subnet.subnet.id

  tags = {
    Name = "${var.server_region}-server"
  }
}
