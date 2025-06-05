module "network" {
  source              = "../network"
  lab_name            = var.lab_name
  cidr_block          = var.cidr_block
  public_cidr_block_a = var.public_cidr_block_a
  public_cidr_block_b = var.public_cidr_block_b
  private_cidr_block  = var.private_cidr_block
  public_zone_a       = var.public_zone_a
  public_zone_b       = var.public_zone_b
  private_zone        = var.private_zone

  tags = {
    Project = "aws-final-lab"
    Owner   = var.lab_name
  }
}

module "securityGroups" {
  source  = "../securityGroups"
  vpc_id  = module.network.vpc.id
  tags    = {
    Project = "aws-final-lab"
    Owner   = var.lab_name
  }
}

module "ec2" {
  source           = "../ec2"
  ami_id           = data.aws_ami.ubuntu.id
  subnet_id        = module.network.public_subnet_a.id
  ssh_key_name     = aws_key_pair.ec2_key.key_name
  private_key_pem  = tls_private_key.privateKey.private_key_pem
  sg_bastion_id    = module.securityGroups.sg_bastion.id
  lab_name         = var.lab_name
}

module "loadbalancer" {
  source            = "../loadbalancer"
  vpc_id            = module.network.vpc.id
  public_subnet_ids = [module.network.public_subnet_a.id, module.network.public_subnet_b.id]
  sg_public_id      = module.securityGroups.sg_public.id
  lab_name          = var.lab_name
}

module "autoscalingGroups" {
  source            = "../autoscalingGroups"
  ami_id            = data.aws_ami.ubuntu.id
  subnet_ids        = [module.network.private_subnet.id]
  asg_sg_id         = module.securityGroups.sg_private.id
  key_name          = aws_key_pair.ec2_key.key_name
  lab_name          = var.lab_name
  target_group_arn  = module.loadbalancer.web_tg_arn
}
