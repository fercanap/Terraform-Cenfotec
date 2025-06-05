variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "Lista de subnets públicas para el ALB"
  type        = list(string)
}

variable "sg_public_id" {
  description = "Security Group para el ALB"
  type        = string
}

variable "lab_name" {
  description = "Nombre del laboratorio"
  type        = string
}
