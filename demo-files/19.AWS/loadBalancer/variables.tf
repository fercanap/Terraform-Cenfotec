variable "lab_name" {
  type = string
}

variable "vpc" {
  type = any
}

# security groups
variable "sgPublic" {
  type = any
}

# subnets
variable "public_subnet_a" {
  type = any
}
variable "public_subnet_b" {
  type = any
}
variable "igw" {
  type = any
}
