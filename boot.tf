# 1. Referensi Data Eksternal Image Ubuntu
data "google_compute_image" "ubuntu" {
  family  = "ubuntu-2404-lts-amd64"
  project = "ubuntu-os-cloud"
}

# 2. Definisi Standalone Boot Disk
resource "google_compute_disk" "boot_disk" {
  name  = "boot-disk-ubuntu"
  type  = "pd-balanced"
  zone  = "asia-southeast2-a"
  size  = 30
  image = data.google_compute_image.ubuntu.self_link

  lifecycle {
    ignore_changes = [image]
  }
}