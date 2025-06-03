variable "bucket" {
  type    = string
  default = "terraformlabs-test-bucket-100"
}
variable "media" {
  type = set(string)
  default = [
    "../../assets/demo_func01.png",
    "../../assets/demo_func02.jpg",
    "../../assets/demo_func03.png",
  ]
}

# segunda parte
variable "name" {
  type = string
	description = "Nombre de la instancia"
}
variable "size" {
  type        = string
  description = "Tamaño de la instancia: small - large"
}
variable "small" {
  type    = string
  default = "t2.micro"
}
variable "large" {
  type    = string
  default = "t2.nano"
}
