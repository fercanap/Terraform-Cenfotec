resource "aws_s3_bucket" "media" {
  bucket = var.bucket
}

resource "aws_s3_object" "upload_media" {
  bucket = aws_s3_bucket.media.id

  source   = each.value
  for_each = var.media
  key      = substr(each.value, 6, 23)
}

resource "aws_instance" "server" {
  ami           = "ami-033b95fb8079dc481"
  instance_type = var.size == "small" ? var.small : var.large
  tags = {
    Name = var.name
  }
}
