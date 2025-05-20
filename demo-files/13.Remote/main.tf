resource "local_file" "state_demo" {
  filename = "local"
  content  = "Archivo de estado: local"
}

resource "aws_s3_bucket" "remote_state" {
  bucket = "terralabs-remote-state-01" # el nombre del bucket debe ser unico.

  tags = {
    Environment = "dev"
  }
}

resource "aws_s3_bucket_public_access_block" "access" {
  bucket = aws_s3_bucket.remote_state.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_ownership_controls" "owner" {
  depends_on = [aws_s3_bucket_public_access_block.access]

  bucket = aws_s3_bucket.remote_state.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "remote_state" {
	depends_on = [aws_s3_bucket_ownership_controls.owner]

  bucket = aws_s3_bucket.remote_state.id
  acl    = "private"
}


