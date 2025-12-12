# MySQL Standalone - Port 3307

MySQL standalone yang berjalan di port 3307, terpisah dari MySQL XAMPP (port 3306).

---

## Daftar Isi

1. [Setup](#setup)
2. [Perintah Dasar](#perintah-dasar)
3. [Koneksi ke MySQL](#koneksi-ke-mysql)
4. [Manajemen User](#manajemen-user)
5. [Manajemen Database](#manajemen-database)
6. [Akses Remote](#akses-remote)
7. [Troubleshooting](#troubleshooting)

---

## Setup

1. Copy `my.ini.example` menjadi `my.ini`
2. Sesuaikan path `basedir` dan `datadir` sesuai lokasi instalasi Anda
3. Inisialisasi database:
   ```cmd
   mysqld --initialize-insecure --user=mysql
   ```
4. Install sebagai service:
   ```cmd
   mysqld --install MySQL3307 --defaults-file="path\to\my.ini"
   ```
5. Jalankan service:
   ```cmd
   net start MySQL3307
   ```

### Konfigurasi Default

| Item | Value |
|------|-------|
| Port | 3307 |
| Storage Engine | InnoDB |
| Character Set | utf8mb4 |
| Collation | utf8mb4_general_ci |

---

## Perintah Dasar

### Menjalankan Service
```cmd
net start MySQL3307
```

### Menghentikan Service
```cmd
net stop MySQL3307
```

### Cek Status Service
```cmd
sc query MySQL3307
```

### Restart Service
```cmd
net stop MySQL3307 && net start MySQL3307
```

---

## Koneksi ke MySQL

### Via Command Line
```cmd
mysql -u root -P 3307 -p
```

### Via Navicat / DBeaver / HeidiSQL

| Field | Value |
|-------|-------|
| Host | `localhost` atau `127.0.0.1` |
| Port | `3307` |
| User | `root` |
| Password | *(sesuai yang di-set)* |

---

## Manajemen User

### Lihat Semua User
```sql
SELECT User, Host FROM mysql.user;
```

### Set Password Root
```sql
ALTER USER 'root'@'localhost' IDENTIFIED BY 'password_baru';
FLUSH PRIVILEGES;
```

### Buat User Baru
```sql
CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
```

### Hapus User
```sql
DROP USER 'username'@'localhost';
FLUSH PRIVILEGES;
```

### Berikan Hak Akses ke Database
```sql
GRANT ALL PRIVILEGES ON nama_database.* TO 'username'@'localhost';
FLUSH PRIVILEGES;
```

### Lihat Hak Akses User
```sql
SHOW GRANTS FOR 'username'@'localhost';
```

### Cabut Hak Akses
```sql
REVOKE ALL PRIVILEGES ON nama_database.* FROM 'username'@'localhost';
FLUSH PRIVILEGES;
```

---

## Manajemen Database

### Lihat Semua Database
```sql
SHOW DATABASES;
```

### Buat Database Baru
```sql
CREATE DATABASE nama_database;
```

### Gunakan Database
```sql
USE nama_database;
```

### Hapus Database
```sql
DROP DATABASE nama_database;
```

### Lihat Tabel dalam Database
```sql
SHOW TABLES;
```

---

## Akses Remote

Agar MySQL bisa diakses dari komputer lain:

### 1. Buat User Remote
```sql
CREATE USER 'remoteuser'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'remoteuser'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```

### 2. Edit `my.ini`
Tambahkan di bagian `[mysqld]`:
```ini
bind-address=0.0.0.0
```

### 3. Restart MySQL
```cmd
net stop MySQL3307 && net start MySQL3307
```

### 4. Buka Firewall Port 3307
1. Buka **Windows Defender Firewall** → **Advanced Settings**
2. **Inbound Rules** → **New Rule**
3. Pilih **Port** → **TCP** → **3307**
4. **Allow the connection**
5. Beri nama: `MySQL Remote 3307`

### 5. Koneksi dari Client
| Field | Value |
|-------|-------|
| Host | IP Server (contoh: `192.168.1.100`) |
| Port | `3307` |
| User | `remoteuser` |
| Password | sesuai yang dibuat |

---

## Troubleshooting

### Error: "The service already exists"
```cmd
sc delete MySQL3307
mysqld --install MySQL3307 --defaults-file="path\to\my.ini"
net start MySQL3307
```

### Error: "System error 2 - File not found"
Service mengarah ke lokasi salah. Hapus dan install ulang:
```cmd
sc delete MySQL3307
mysqld --install MySQL3307 --defaults-file="path\to\my.ini"
```

### Error: "InnoDB: Data Files Corrupt"
```cmd
net stop MySQL3307
rmdir /s /q "path\to\data"
mysqld --initialize-insecure --user=mysql
net start MySQL3307
```

### Hapus Service MySQL
```cmd
net stop MySQL3307
sc delete MySQL3307
```

### Re-install dari Awal
```cmd
sc delete MySQL3307
rmdir /s /q "path\to\data"
mysqld --initialize-insecure --user=mysql
mysqld --install MySQL3307 --defaults-file="path\to\my.ini"
net start MySQL3307
```

---

## Catatan Keamanan

- Jangan gunakan `root@%` di server publik
- Gunakan user terbatas untuk akses remote
- Batasi akses ke IP tertentu jika memungkinkan:
  ```sql
  CREATE USER 'user'@'192.168.1.10' IDENTIFIED BY 'password';
  ```
