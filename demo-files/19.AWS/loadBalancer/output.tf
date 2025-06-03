output "tgWebserver_arn" {
  value = aws_lb_target_group.tgWebserver.arn
}

output "albWebserver" {
  value = aws_lb.albWebserver
}
