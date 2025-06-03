resource "aws_instance" "demo-import" {
  ami                         = "ami-033b95fb8079dc481"
  associate_public_ip_address = false
  availability_zone           = "us-east-1a"
  instance_type               = "t3a.nano"
  subnet_id                   = "subnet-053e40d26eb90fed7"

}
