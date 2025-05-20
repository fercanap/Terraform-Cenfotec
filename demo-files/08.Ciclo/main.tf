resource "local_file" "file" {
  filename        = var.filename
  file_permission = 0700
  # file_permission = 0777
  content         = "Hello World"
  # content = "Bye..."

  # lifecycle {
  #   create_before_destroy = true
	# 	# prevent_destroy = true
  # }
}
