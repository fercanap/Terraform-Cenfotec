resource "google_compute_firewall" "custom" {
  name    = "custom"
  network = module.network.network_id

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  source_ranges = ["0.0.0.0/0"]
}
