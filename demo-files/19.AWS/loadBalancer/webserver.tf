resource "aws_lb_target_group" "tgWebserver" {
  name     = "tgWebserver"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc.id
}

resource "aws_lb" "albWebserver" {
  name               = "albWebserver-${var.lab_name}"
  load_balancer_type = "application"
  internal           = false
  subnets            = [var.public_subnet_a.id, var.public_subnet_b.id]
  security_groups    = [var.sgPublic.id]
}

resource "aws_lb_listener" "listener_80_webserver" {
  load_balancer_arn = aws_lb.albWebserver.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tgWebserver.arn

    # Opcional: redirect 443
    # type = "redirect"

    # redirect {
    #   port        = "443"
    #   protocol    = "HTTPS"
    #   status_code = "HTTP_301"
    # }
  }
}

# Opcional: 443 listener
# resource "aws_lb_listener" "listener_443_webserver" {
#   load_balancer_arn = aws_lb.albWebserver.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = var.cert_arn

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.tgWebserver.arn
#   }
# }
