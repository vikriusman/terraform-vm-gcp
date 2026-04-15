output "vm_public_ip" {
  description = "Alamat Public IP dari VM"
  value       = google_compute_instance.vm_ubuntu.network_interface[0].access_config[0].nat_ip
}
