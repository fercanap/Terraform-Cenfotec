cd ..resource "local_file" "password" {
  content  = "Password: ${random_string.iac_random.result}"
  filename = "password.txt"

  file_permission      = "0400" # Para el archivo password.txt
  directory_permission = "0700" # Para el directorio (si se crea),
}
