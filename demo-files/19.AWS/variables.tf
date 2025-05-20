variable "lab_name" {
  type        = string
  description = "Nombre del estudiante"

  validation {
    condition     = length(var.lab_name) >= 3
    error_message = "El nombre debe ser mayor a 3 caracteres."
  }
}

variable "key_name" {
  type        = string
  description = "Nombre de la llave SSH para conectar con el Bastion host"
}
variable "cidr_block" {
  type        = string
  description = "Bloque de IP's para la VPC"
}
variable "public_cidr_block_a" {
  type        = string
  description = "Bloque de IP's para la subnet pública"
}
variable "public_cidr_block_b" {
  type        = string
  description = "Bloque de IP's para la subnet pública"
}
variable "private_cidr_block" {
  type        = string
  description = "Bloque de IP's para la subnet privada"
}
variable "public_zone_a" {
  type        = string
  description = "Zona de acceso público A"
}
variable "public_zone_b" {
  type        = string
  description = "Zona de acceso público B"
}
variable "private_zone" {
  type        = string
  description = "Zona de acceso privado"
}

variable "domain" {
	type = string
	description = "Dominio DNS"
}



