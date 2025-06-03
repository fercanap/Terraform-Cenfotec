resource "local_sensitive_file" "tempfile" {
  filename          = var.users[count.index]
  content = "password: S3cr3tP@ssw0rd"
  count             = length(var.users)
}

resource "local_sensitive_file" "tempfile_for" {
  for_each          = toset(var.users)
  filename          = each.value
  content = "password: S3cr3tP@ssw0rd"
}