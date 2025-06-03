resource "random_string" "iac_random" {
  length    = var.length
  min_upper = var.min_upper
}
