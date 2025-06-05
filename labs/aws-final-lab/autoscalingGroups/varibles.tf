variable "lab_name" {
  description = "Nombre del laboratorio (se usa en tags y nombres)"
  type        = string
}

variable "ubuntu_ami" {
  description = "Data source con la AMI Ubuntu 20.04"
  type        = any
}

variable "private_subnet" {
  description = "Subred privada donde vive la aplicación"
  type        = any
}

variable "sg_private" {
  description = "Security group privado para las instancias"
  type        = any
}

variable "ssh_key" {
  description = "Recurso aws_key_pair definido en root"
  type        = any
}

variable "tgWebserver_arn" {
  description = "ARN del Target Group HTTP del ALB"
  type        = string
}
