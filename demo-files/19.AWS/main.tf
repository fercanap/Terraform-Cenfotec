module "network" {
  source = "./network"

  lab_name            = var.lab_name
  cidr_block          = var.cidr_block
  public_cidr_block_a = var.public_cidr_block_a
  public_cidr_block_b = var.public_cidr_block_b
  private_cidr_block  = var.private_cidr_block
  public_zone_a       = var.public_zone_a
  public_zone_b       = var.public_zone_b
  private_zone        = var.private_zone
}

module "security_groups" {
  source = "./securityGroups"

  vpc = module.network.vpc
}

module "ec2" {
  source = "./ec2"

  lab_name        = var.lab_name
  ubuntu_ami      = data.aws_ami.ubuntu
  ssh_key         = aws_key_pair.ec2_key
  private_key_pem = tls_private_key.privateKey.private_key_pem
  public_subnet_a = module.network.public_subnet_a
  public_subnet_b = module.network.public_subnet_b
  sgBastion       = module.security_groups.sgBastion
}

module "loadbalancer" {
  source = "./loadBalancer"

  lab_name        = var.lab_name
  vpc             = module.network.vpc
  igw             = module.network.igw
  public_subnet_a = module.network.public_subnet_a
  public_subnet_b = module.network.public_subnet_b
  sgPublic        = module.security_groups.sgPublic
}

module "autoscaling" {
  source = "./autoscalingGroups"

  lab_name        = var.lab_name
  ubuntu_ami      = data.aws_ami.ubuntu
  ssh_key         = aws_key_pair.ec2_key
  private_subnet  = module.network.private_subnet
  sgPrivate       = module.security_groups.sgPrivate
  tgWebserver_arn = module.loadbalancer.tgWebserver_arn
}

module "dns" {
  source = "./dns"

  lab_name     = var.lab_name
  domain       = var.domain
  albWebserver = module.loadbalancer.albWebserver
}


