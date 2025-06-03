resource "aws_s3_bucket" "demo_bucket" {
  bucket = "terralabs-fercanap123654" # el nombre del bucket debe ser unico.

	tags = {
    Name        = "El bucket de Fer"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_public_access_block" "access" {
  bucket = aws_s3_bucket.demo_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "owner" {
  bucket = aws_s3_bucket.demo_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


resource "aws_s3_bucket_acl" "bucket_acl" {
	depends_on = [ aws_s3_bucket_ownership_controls.owner, aws_s3_bucket_public_access_block.access ]

  bucket = aws_s3_bucket.demo_bucket.id
  acl    = "public-read"
}

resource "aws_s3_object" "demo_file" {
  bucket      = aws_s3_bucket.demo_bucket.id
  key         = "demo_s3.png"
  source      = "../../assets/demo_s3.png"
  content_type = "image/jpeg"

  acl = "public-read"
}
