# resource "aws_route53_zone" "main" {
#   name = var.domain

#   lifecycle {
#     # prevent_destroy = true
#     ignore_changes  = [
# 			tags
# 		]
#   }
# }

# records
resource "aws_route53_record" "webpage" {
  zone_id =  "Z0439920GUKKIZ3LG696" // aws_route53_zone.main.zone_id
  name    = "${var.lab_name}.${var.domain}"
  type    = "CNAME"
  ttl     = 60
  records = [var.albWebserver.dns_name]
}






