variable "region" {
  type = map(any)
  default = {
    "segundo" = "us-east-1"
    "tercero" = "us-east-2"
  }

}
variable "ami" {
  type = map(any)
  default = {
    "segundo" = "ami-033b95fb8079dc481"
    "tercero" = "ami-0b614a5d911900a9b"
  }
}
