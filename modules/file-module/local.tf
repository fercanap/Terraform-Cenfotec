resource "local_file" "module-demo" {
  filename = var.in-filename
  content  = "Este es mi primer módulo"
}
