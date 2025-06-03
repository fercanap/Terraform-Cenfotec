output "instance_size" {
  value = aws_instance.server.instance_type
}

output "instance_id" {
  value = aws_instance.server.id
}

output "availability_zone" {
  value = aws_instance.server.availability_zone
}

output "instance_name" {
  value = aws_instance.server.tags.Name
}
