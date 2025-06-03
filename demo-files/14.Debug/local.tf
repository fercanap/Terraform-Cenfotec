resource "local_file" "demo01" {
  filename        = "/error/demo01.txt"
  sensitive_content = "Este es mi primer lab de Terraform"
  # file_permission = "0644"
}
