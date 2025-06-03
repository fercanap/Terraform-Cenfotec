resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key_pem" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "${var.key_name}.pem"
  file_permission = "0600"
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  force_destroy = true

  tags = {
    Name        = var.bucket_name
    Environment = "Practica1"
  }
}

resource "aws_s3_object" "ssh_key_upload" {
  bucket = aws_s3_bucket.bucket.id
  key    = "${var.key_name}.pem"
  content = tls_private_key.ssh_key.private_key_pem

  # Evitar warning de ACL deprecado
  object_lock_mode = null
}

resource "aws_vpc" "lab_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "lab-fercanap"
  }
}
