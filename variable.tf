variable "project_id" {
  description = "ID Project Google Cloud kamu"
  type        = string
  default     = "april2026-project"
}

variable "vm_name" {
  default = "vm-created-by-teraform"
}

variable "ssh_keys" {
  description = "Daftar SSH Keys yang akan didaftarkan (berisi user dan path ke file public key)"
  type = list(object({
    user         = string
    pub_key_file = string
  }))
  default = [
    {
      user         = "vikri"
      pub_key_file = "/home/vikri/.ssh/id_ed25519.pub"
    }
  ]
}
