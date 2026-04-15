resource "google_compute_firewall" "allow_8080" {
  name    = "allow-port-8080"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  target_tags   = ["web-server-port"]
  source_ranges = ["0.0.0.0/0"]
}
