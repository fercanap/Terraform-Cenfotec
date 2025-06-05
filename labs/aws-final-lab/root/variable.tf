variable "lab_name" {
  description = "Nombre del estudiante"
  type        = string
  validation {
    condition     = length(var.lab_name) >= 3
    error_message = "El nombre debe tener al menos 3 caracteres."
  }
}

variable "key_name" {
  description = "Nombre de la llave SSH para conectar con el Bastion host"
  type        = string
}

variable "cidr_block" {
  description = "Bloque CIDR para la VPC"
  type        = string
}

variable "public_cidr_block_a" {
  description = "Bloque de IPs para la subnet pública A"
  type        = string
}

variable "public_cidr_block_b" {
  description = "Bloque de IPs para la subnet pública B"
  type        = string
}

variable "private_cidr_block" {
  description = "Bloque de IPs para la subnet privada"
  type        = string
}

variable "public_zone_a" {
  description = "Zona pública A"
  type        = string
}

variable "public_zone_b" {
  description = "Zona pública B"
  type        = string
}

variable "private_zone" {
  description = "Zona privada"
  type        = string
}
