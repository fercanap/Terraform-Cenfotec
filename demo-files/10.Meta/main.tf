resource "local_file" "tempfile" {
  filename = "tempfile"
  # filename          = var.users[count.index]
  sensitive_content = "password: S3cr3tP@ssw0rd"
  count             = 3
  # count             = length(var.users)
}

# resource "local_file" "tempfile_for" {
#   filename          = each.value
#   for_each          = toset(var.users)
#   sensitive_content = "password: S3cr3tP@ssw0rd"
# }




