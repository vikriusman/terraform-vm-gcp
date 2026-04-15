# 1. Definisi Custom VPC Network
resource "google_compute_network" "custom_vpc" {
  name                    = "custom-vpc-network"
  auto_create_subnetworks = false
}

# 2. Definisi Custom Subnetwork
resource "google_compute_subnetwork" "custom_subnet" {
  name          = "custom-subnet-asia"
  ip_cidr_range = "10.0.1.0/24"
  region        = "asia-southeast2"
  network       = google_compute_network.custom_vpc.id
}
