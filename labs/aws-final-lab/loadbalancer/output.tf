output "alb_dns_name" {
  value       = aws_lb.web_alb.dns_name
  description = "Public DNS name of the ALB"
}

output "web_tg_arn" {
  value = aws_lb_target_group.web_tg.arn
}
