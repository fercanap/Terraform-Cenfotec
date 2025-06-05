module "network" {
  source              = "./network"
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
