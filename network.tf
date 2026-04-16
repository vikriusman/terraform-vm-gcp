resource "google_compute_firewall" "allow_8080" {
  name    = "allow-port-8080"
  network = google_compute_network.vm_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  target_tags   = ["web-server-port"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh-custom"
  network = google_compute_network.vm_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}
