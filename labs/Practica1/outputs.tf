output "private_key_path" {
  description = "Ruta del archivo de la llave privada"
  value       = local_file.private_key_pem.filename
}

output "s3_object_url" {
  description = "URL del objeto en el bucket S3"
  value       = "https://${aws_s3_bucket.bucket.bucket}.s3.amazonaws.com/${aws_s3_object.ssh_key_upload.key}"
}

output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.lab_vpc.id
}