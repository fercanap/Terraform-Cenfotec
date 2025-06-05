variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "tags" {
  description = "Etiquetas comunes para los recursos"
  type        = map(string)
}
