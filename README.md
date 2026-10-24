# Tanamku

Aplikasi katalog tanaman hias dan panduan perawatannya, dibuat dengan Flutter untuk UTS Mobile Programming.

## Tema dan tujuan
Tanamku membantu pemula memilih dan merawat tanaman hias. Pengguna dapat menjelajahi tanaman per kategori, menyaring berdasarkan tingkat kesulitan dan kebutuhan cahaya, membaca panduan perawatan, lalu menyimpan tanaman yang disukai ke daftar favorit.

## Halaman dan fungsinya
| Halaman | Navigasi | Fungsi |
|---|---|---|
| Beranda | BottomNavigationBar tab 1 | Sapaan, kategori, favoritku, tanaman hari ini, populer, cocok untuk pemula, tips |
| Jelajah | BottomNavigationBar tab 2 | Daftar tanaman per kategori, pencarian, filter kesulitan dan cahaya |
| Favorit | BottomNavigationBar tab 3 | Kumpulan tanaman yang diberi tanda hati |
| Detail Tanaman | `Navigator.pushNamed('/detail')` | Foto, deskripsi, panduan perawatan, tips, keamanan untuk hewan peliharaan |

## Struktur data
Data tanaman disimpan di `assets/data/plants.json` (13 tanaman, 5 kategori). Semua akses lewat `lib/data/plant_repository.dart`, sehingga saat integrasi API cukup mengganti isi repository tanpa mengubah halaman.

## Foto tanaman
Letakkan foto di `assets/images/` dengan nama `<id>.jpg`, misalnya `monstera.jpg`. Jika foto belum ada, aplikasi menampilkan ilustrasi sementara. Cantumkan sumber foto (foto sendiri atau lisensi bebas seperti Unsplash atau Pexels) di laporan.

## Cara menjalankan
1. `flutter create . --platforms=android` (di dalam folder proyek)
2. `flutter pub get`
3. `flutter run`
