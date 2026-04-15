# 1. Definisi Disk Tambahan (Persistent Disk)
resource "google_compute_disk" "disk_data" {
  name  = "disk-data-app"
  type  = "pd-ssd"               # Opsi: pd-standard, pd-balanced, pd-ssd
  zone  = "asia-southeast2-a"
  size  = 50                     # Ukuran dalam GB
}

# 2. Definisi VM Instance
resource "google_compute_instance" "vm_ubuntu" {
  name         = "ubuntu-custom-server"
  
  # FORMAT CUSTOM: custom-VCPU-MEMORYMB
  # Contoh: 2 vCPU dan 4GB RAM (4 * 1024 = 4096)
  machine_type = "e2-custom-2-4096" 
  
  zone         = "asia-southeast2-a"

  # Menggunakan Tag agar bisa kena aturan Firewall port 8080 dari network.tf
  tags = ["web-server-port"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
      size  = 30 # Disk OS 30GB
    }
  }

  network_interface {
    network = "default"
    access_config {
      # Kosongkan untuk mendapatkan Public IP
    }
  }

  labels = {
    environment = "experimental"
    os          = "ubuntu-24-04"
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }
}

# 3. Menempelkan Disk Tambahan ke VM
resource "google_compute_attached_disk" "attach_data" {
  disk     = google_compute_disk.disk_data.id
  instance = google_compute_instance.vm_ubuntu.id
}
