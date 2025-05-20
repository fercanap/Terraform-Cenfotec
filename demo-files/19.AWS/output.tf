output "bastion_host" {
  value       = "ssh -i key.pem ubuntu@${module.ec2.bastion_public_ip}"
  description = "bastion SSH"
}

output "albWebserver_dns_name" {
  value = module.loadbalancer.albWebserver.dns_name
}
