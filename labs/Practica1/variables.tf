variable "key_name" {
  description = "Nombre del archivo de llave SSH sin extensión"
  type        = string
}

variable "bucket_name" {
  description = "Nombre del bucket S3"
  type        = string
  default     = "fercanap-practica1"
}
