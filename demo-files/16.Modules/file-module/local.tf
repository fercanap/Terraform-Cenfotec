resource "local_file" "module-demo" {
  filename = var.filename
  content  = "Este es mi primer módulo"
}
