terraform {
  required_providers {
    aws = {
      version = "~> 4.0"
    }
  }

 backend "s3" {
    key              = "terraform.tfstate"
  region           = "us-east-2"
  bucket           = "terralabs-remote-state-fca01" # Nombre del bucket creado en pasos
  }
}

