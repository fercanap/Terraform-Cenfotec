module "server" {
  source        = "./modules"
  server_region = lookup(var.region, terraform.workspace)
  ami           = lookup(var.ami, terraform.workspace)
}
