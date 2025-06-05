resource "aws_lb" "web_alb" {
  name               = "alb-${var.lab_name}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_public_id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = "alb-${var.lab_name}"
  }
}

resource "aws_lb_target_group" "web_tg" {
  name     = "tg-${var.lab_name}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "tg-${var.lab_name}"
  }
}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}
