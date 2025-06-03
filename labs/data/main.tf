
data "local_file" "os" {
  filename = "/etc/os-release"
}

output "os-version" {
  value = data.local_file.os.content
}
