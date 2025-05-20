# SSH
resource "aws_security_group" "sgBastion" {
  vpc_id      =  var.vpc.id
  name        =  "sgBastion"
  description = "Comunicacion atraves del Bastion Host"
}

# ingress
resource "aws_security_group_rule" "sg_ingress_rule_bastion" {
  type        = "ingress"
  description = "SSH from Internet"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sgBastion.id
}

# egress
resource "aws_security_group_rule" "sg_egress_rule_bastion" {
  type        = "egress"
  description = "to Internet"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sgBastion.id
}
