# 1. Definisi Custom VPC Network
resource "google_compute_network" "vm_vpc" {
  name                    = "vm-vpc-network"
  auto_create_subnetworks = false
}

# 2. Definisi Custom Subnetwork
resource "google_compute_subnetwork" "vm_subnet" {
  name          = "vm-subnet-sea"
  ip_cidr_range = "10.10.0.0/24"
  region        = "asia-southeast2"
  network       = google_compute_network.vm_vpc.id
}
