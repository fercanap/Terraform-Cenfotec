<<<<<<< HEAD
variable "ami_id" {
  description = "AMI ID for app instances"
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs for ASG"
  type        = list(string)
}

variable "asg_sg_id" {
  description = "Security group for the ASG instances"
  type        = string
}

variable "key_name" {
  description = "SSH key name"
  type        = string
}

variable "lab_name" {
  description = "Lab name prefix"
  type        = string
}

variable "target_group_arn" {
  description = "Target group ARN from ALB"
  type        = string
=======
variable "lab_name" {
  type = string
}

variable "ubuntu_ami" {
  type = any
}

variable "private_subnet" {
  type = any
}

variable "sg_private" {
  type = any
}

variable "ssh_key" {
  type = any
}

variable "tgWebserver_arn" {
  type = string
>>>>>>> b07d844a (Reinicializa y agrega los archivos del lab final)
}
