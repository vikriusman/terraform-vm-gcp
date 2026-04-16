terraform {
  backend "gcs" {
    bucket  = "terra-test" # Ganti dengan nama bucket GCS Anda
    prefix  = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = "asia-southeast2"
}
