resource "aws_s3_bucket" "demo_bucket" {
  bucket = "terralabs-carlos-785542"

   tags = {
    Name        = "My bucket"
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
  depends_on = [aws_s3_bucket_public_access_block.access]

  bucket = aws_s3_bucket.demo_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "aws_s3_bucket_acl" {
  depends_on = [ aws_s3_bucket_ownership_controls.owner ]
  bucket =  aws_s3_bucket.demo_bucket.id
  acl = "public-read"
}

resource "aws_s3_object" "demo_file" {
  bucket =  aws_s3_bucket.demo_bucket.id
  key = "demo_s3.png"
  source = "../assets/demo_s3.png"
  content_type = "image/jpeg"

  acl ="public-read"
}
output "bucket_url" {
    value =" ${ aws_s3_object.demo_file.bucket }.s3.amazonaws.com/${  aws_s3_object.demo_file.key  }  "
}
