output "bucket_url" {
  value = {
    for k, v in aws_s3_object.upload_media : k => "${v.bucket}.s3.amazonaws.com/${v.key}"
  }
}

output "instance_size" {
	value = "${aws_instance.server.instance_type}"
}
