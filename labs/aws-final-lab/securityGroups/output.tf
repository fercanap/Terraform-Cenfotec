output "sg_bastion" {
  value = aws_security_group.bastion
}

output "sg_public" {
  value = aws_security_group.public
}

output "sg_private" {
  value = aws_security_group.private
}
