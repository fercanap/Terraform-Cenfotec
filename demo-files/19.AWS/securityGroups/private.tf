
# PRIVATE WEB
resource "aws_security_group" "sgPrivate" {
  vpc_id      = var.vpc.id
  name        = "sgPrivate"
  description = "Comunicacion PRIVADA http - https - ssh"
}

# ingress

resource "aws_security_group_rule" "sg_ingress_rule_private_ssh" {
  type                     = "ingress"
  description              = "from Bastion"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sgBastion.id

  security_group_id = aws_security_group.sgPrivate.id
}

resource "aws_security_group_rule" "sg_ingress_rule_private_http" {
  type                     = "ingress"
  description              = "from public SG (Load Balancer)"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sgPublic.id

  security_group_id = aws_security_group.sgPrivate.id
}

resource "aws_security_group_rule" "sg_ingress_rule_private_https" {
  depends_on = [aws_security_group.sgPublic]

  type                     = "ingress"
  description              = "from public SG (Load Balancer)"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sgPublic.id

  security_group_id = aws_security_group.sgPrivate.id
}

# egress

resource "aws_security_group_rule" "sg_egress_rule_private" {
  type        = "egress"
  description = "to Internet"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.sgPrivate.id
}
