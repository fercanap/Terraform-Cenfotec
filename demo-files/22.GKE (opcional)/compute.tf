data "google_compute_image" "image" {
  family  = "ubuntu-2004-lts"
  project = "ubuntu-os-cloud"
}

resource "google_compute_disk" "disk" {
  name  = "disk"
  image = data.google_compute_image.image.self_link
  size  = 10
  type  = "pd-standard"
  zone  = "us-east1-b"
}

resource "google_compute_address" "static-internal" {
  name         = "compute-static"
  subnetwork   = module.network.subnet_id
  address_type = "INTERNAL"
  address      = "10.0.0.100"
  region       = "us-east1"
}

resource "google_compute_address" "static-external" {
  name   = "compute-ext"
  region = "us-east1"
}

resource "google_compute_instance" "instance01" {
  depends_on = [
    google_compute_firewall.custom
  ]

  name         = "instance01"
  machine_type = "e2-small"
  zone         = "us-east1-b"
  tags         = ["new"]
  labels = {
    env  = "dev"
    team = "devops"
  }

  boot_disk {
    source      = google_compute_disk.disk.id
    auto_delete = false
  }

  network_interface {
    network    = module.network.network_id
    subnetwork = module.network.subnet_id
    network_ip = google_compute_address.static-internal.address

    access_config {
      nat_ip = google_compute_address.static-external.address
    }
  }

  metadata = {
    ssh-keys = "ubuntu1:${tls_private_key.key.public_key_openssh}"
    user-data = templatefile("./config.sh", {
      last_var = "Carlos"
    })
  }

  connection {
    type        = "ssh"
    host        = self.network_interface.0.access_config.0.nat_ip
    user        = "ubuntu1"
    private_key = tls_private_key.key.private_key_pem
  }

  provisioner "file" {
    source      = "hello.txt"
    destination = "/home/ubuntu1/hello.txt"
  }

}


resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "private_key" {
  filename          = "./key"
  sensitive_content = tls_private_key.key.private_key_pem
  file_permission   = "0400"
}

output "ssh" {
  value = "ssh ubuntu1@${google_compute_address.static-external.address} -i key"
}
