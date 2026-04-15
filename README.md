# Terraform GCP VM Setup

Project ini adalah sebuah setup infrastruktur menggunakan **Terraform** untuk membuat Virtual Machine (VM) di Google Cloud Platform (GCP).

## Arsitektur & Komponen

Project ini membuat beberapa komponen infrastruktur di GCP:

1. **Google Compute Instance (VM)**:
   - OS: **Ubuntu 24.04 LTS** (Boot disk: 30 GB)
   - Tipe Mesin: Custom (`e2-custom-2-4096` - 2 vCPU, 4GB RAM)
   - Zona: `asia-southeast2-a`
   - IP Publik otomatis ditambahkan.

2. **Persistent Disk (Data Disk)**:
   - Tipe: SSD (`pd-ssd`)
   - Ukuran: 50 GB
   - Disk terpisah yang otomatis di-_attach_ (dipasangkan) ke dalam VM.

3. **Firewall Rule**:
   - Membuka port **8080** (TCP) untuk VM yang memiliki tag `web-server-port`.
   - Hal ini memungkinkan VM diakses dari internet via HTTP port 8080 jika ada aplikasi yang berjalan di dalam server.

## Struktur File

- `provider.tf` : Konfigurasi provider Google Cloud.
- `compute.tf` : Mendefinisikan resource utama seperti Disk, Instances, dan konfigurasi Attachement disk ke VM.
- `network.tf` : Mendefinisikan _Firewall Rule_ agar VM dapat diakses secara spesifik dari internet pada port tertentu (misal: 8080).
- `variable.tf` : Definisi variabel seperti `project_id`.

## Cara Penggunaan

1. **Inisialisasi Terraform**:
   Jalankan perintah ini untuk mendownload plugin provider.
   ```bash
   terraform init
   ```

2. **Cek Rencana Eksekusi (Plan)**:
   Melihat apa saja yang akan dibuat, diubah, atau dihapus oleh Terraform tanpa mengubah state yang sebenarnya.
   ```bash
   terraform plan -var="project_id=YOUR_PROJECT_ID"
   ```
   *(Atau secara default menggunakan project `april2026-project` yang terdefinisi di variabel)*

3. **Terapkan Perubahan (Apply)**:
   Mengeksekusi konfigurasi Terraform untuk membangun infrastruktur di GCP.
   ```bash
   terraform apply -var="project_id=YOUR_PROJECT_ID"
   ```

4. **Menghapus Infrastruktur (Destroy)**:
   Jika sudah selesai dan ingin menghapus seluruh resource yang terbuat.
   ```bash
   terraform destroy -var="project_id=YOUR_PROJECT_ID"
   ```

## Hak Akses & SSH ke VM

Terraform akan menanamkan (*inject*) daftar *public-key* SSH secara otomatis ke dalam *metadata* VM saat instalasi. Ini memungkinkan Anda untuk login ke VM menggunakan klien SSH biasa.

Anda dapat mendeklarasikan lebih dari satu akses *user* via variabel array (*list of objects*) `ssh_keys` di `variable.tf` atau `.tfvars`:

```hcl
ssh_keys = [
    {
      user         = "devops"
      pub_key_file = "~/id.pub"
    },
    {
      user         = "vikri"
      pub_key_file = "~/.ssh/id_rsa.pub"
    }
]
```

Setelah `terraform apply` berhasil dan Anda mendapatkan **Public IP** dari VM tersebut, login dengan klien SSH:

```bash
ssh devops@<IP_PUBLIC_VM>
```

*(Atau via Google Cloud Console / gcloud CLI jika diperlukan).*
