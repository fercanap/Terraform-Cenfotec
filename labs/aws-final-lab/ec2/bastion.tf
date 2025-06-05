resource "aws_instance" "bastion" {
  ami                         = var.ami_id
  instance_type               = "t3a.nano"
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  key_name                    = var.ssh_key_name
  vpc_security_group_ids      = [var.sg_bastion_id]

  tags = {
    Name = "bastion-${var.lab_name}"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = var.private_key_pem
    host        = self.public_ip
  }

}
