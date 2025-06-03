resource "local_file" "demo01" {
  filename        = "demo01.txt"
  content         = "Este es mi primer lab de Terraform"
  # file_permission = "0644"
}
