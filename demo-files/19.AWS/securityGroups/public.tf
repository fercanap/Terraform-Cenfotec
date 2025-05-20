
# PUBLIC load balancer
resource "aws_security_group" "sgPublic" {
  # depends_on = [var.vpc]

  vpc_id      = var.vpc.id
  name        = "sgPublic"
  description = "Comunicacion http - https"
}

# ingress

resource "aws_security_group_rule" "sg_ingress_rule_public_load_balancer_http" {
  type        = "ingress"
  description = "from Internet"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.sgPublic.id
}

resource "aws_security_group_rule" "sg_ingress_rule_public_load_balancer_https" {
  type        = "ingress"
  description = "from Internet"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.sgPublic.id
}

# egress

resource "aws_security_group_rule" "sg_egress_rule_public_load_balancer" {
  type              = "egress"
  description       = "to Internet"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]

  security_group_id = aws_security_group.sgPublic.id
}
