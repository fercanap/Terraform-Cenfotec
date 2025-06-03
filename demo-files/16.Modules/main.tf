locals {
  filename = "test.txt"
}

module "file-module" {
  source = "./file-module"

  # filename = local.filename
}

# module "file-module-dos" {
#   source = "./file-module"

#   filename = "dos.txt"
# }
