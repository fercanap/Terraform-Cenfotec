resource "tls_private_key" "privateKey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "key_file" {
  content  = tls_private_key.privateKey.private_key_pem
  filename = var.key_name
}

resource "aws_s3_bucket" "bucket_practica" {
  bucket = var.bucket
}

resource "aws_s3_bucket_ownership_controls" "state_control" {
  bucket = aws_s3_bucket.demo_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.state_control]

  bucket = aws_s3_bucket.bucket_practica.id
  acl    = "private"
}

resource "aws_s3_object" "demo_file" {
  # resource "aws_s3_bucket_object" "demo_file" {

  bucket = aws_s3_bucket.bucket_practica.id
  key    = var.key_name
  source = var.key_name

  acl = "private"
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "lab-estudiante"
  }
}
