# MySQL Server Configuration Template

Template konfigurasi MySQL Server yang berjalan di port 3307.

## Setup

1. Copy `my.ini.example` menjadi `my.ini`
2. Sesuaikan path `basedir` dan `datadir` sesuai lokasi instalasi Anda
3. Inisialisasi database:
   ```bash
   mysqld --initialize-insecure
   ```
4. Jalankan MySQL server:
   ```bash
   mysqld --console
   ```

## Konfigurasi Default

- **Port**: 3307
- **Storage Engine**: InnoDB
- **Character Set**: utf8mb4
- **Collation**: utf8mb4_general_ci
