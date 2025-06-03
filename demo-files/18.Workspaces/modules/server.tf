resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_instance" "server" {
  ami           = var.ami
  instance_type = "t2.nano"
  tags = {
    Name = "${var.server_region}-server"
  }
}
