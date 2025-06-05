variable "lab_name" {
  description = "Nombre del laboratorio"
  type        = string
}

variable "cidr_block" {
  description = "Bloque CIDR para la VPC"
  type        = string
}

variable "public_cidr_block_a" {
  description = "CIDR para la subnet pública A"
  type        = string
}

variable "public_cidr_block_b" {
  description = "CIDR para la subnet pública B"
  type        = string
}

variable "private_cidr_block" {
  description = "CIDR para la subnet privada"
  type        = string
}

variable "public_zone_a" {
  description = "Zona de disponibilidad para subnet pública A"
  type        = string
}

variable "public_zone_b" {
  description = "Zona de disponibilidad para subnet pública B"
  type        = string
}

variable "private_zone" {
  description = "Zona de disponibilidad para subnet privada"
  type        = string
}

variable "tags" {
  description = "Etiquetas comunes para los recursos"
  type        = map(string)
}
