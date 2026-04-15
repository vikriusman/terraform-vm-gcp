variable "project_id" {
  description = "ID Project Google Cloud kamu"
  type        = string
  default     = "april2026-project"
}

variable "vm_name" {
  default = "vm-created-by-teraform"
}

variable "ssh_user" {
  description = "Username untuk login SSH"
  type        = string
  default     = "devops"
}

variable "ssh_pub_key_file" {
  description = "Path ke file public key untuk SSH"
  type        = string
  default     = "~/id.pub"
}
