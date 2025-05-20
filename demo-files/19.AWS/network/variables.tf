variable "lab_name" {
	type = string
	description = "Nombre del estudiante"
}
variable "cidr_block" {
	type = string
	description = "Bloque de IP's para la VPC"
}
variable "public_cidr_block_a" {
	type = string
	description = "Bloque de IP's para la subnet pública A"
}
variable "public_cidr_block_b" {
	type = string
	description = "Bloque de IP's para la subnet pública B"
}
variable "private_cidr_block" {
	type = string
	description = "Bloque de IP's para la subnet privada"
}
variable "public_zone_a" {
	type = string
	description = "Zona de acceso público"
}
variable "public_zone_b" {
	type = string
	description = "Zona de acceso privado"
}
variable "private_zone" {
	type = string
	description = "Zona de acceso privado"
}





