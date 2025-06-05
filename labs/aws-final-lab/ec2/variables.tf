variable "ami_id" {
  description = "AMI Ubuntu ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet pública para el bastion"
  type        = string
}

variable "ssh_key_name" {
  description = "Nombre de la llave SSH creada"
  type        = string
}

variable "private_key_pem" {
  description = "Llave privada PEM para conexión SSH"
  type        = string
  sensitive   = true
}

variable "sg_bastion_id" {
  description = "ID del Security Group para el bastion"
  type        = string
}

variable "lab_name" {
  description = "Nombre del laboratorio"
  type        = string
}
