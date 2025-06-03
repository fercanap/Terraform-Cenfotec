resource "aws_instance" "ec2Bastion" {
  instance_type = "t3a.nano"
  ami           = var.ubuntu_ami.id
  subnet_id     = var.public_subnet_a.id
  # security_groups             = [var.sgBastion.id]
  vpc_security_group_ids      = [var.sgBastion.id]
  associate_public_ip_address = true
  key_name                    = var.ssh_key.key_name

  hibernation = false
  credit_specification {
    cpu_credits = "unlimited"
  }

  tags = {
    Name = "bastion-${var.lab_name}"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu" # usuario por defecto en AWS
    private_key = var.private_key_pem # llave privada: key.pem
  }

  provisioner "file" {
    source      = "./key.pem"
    destination = "/home/ubuntu/.ssh/id_rsa" # directorio por defecto donde se ubican las llaves ssh
  }

  // Opcional:
  provisioner "local-exec" {
    command = <<EOT
			ssh-keygen -f ~/.ssh/known_hosts -R "${self.public_ip}"
  	EOT
  }
}



