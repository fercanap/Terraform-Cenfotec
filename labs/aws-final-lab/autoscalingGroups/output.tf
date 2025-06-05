output "asg_name" {
  description = "Nombre del Auto Scaling Group creado"
  value       = aws_autoscaling_group.asg_webserver.name
}
