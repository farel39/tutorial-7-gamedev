

## Fitur Tambahan

### 1. Sprinting & Crouching
Saya menambahkan fitur agar pemain dapat berlari (*sprint*) dan menunduk (*crouch*) untuk memberikan variasi pergerakan saat melewati rintangan.
* **Proses Implementasi:** Mekanik ini diimplementasikan dengan menambahkan *input action* baru (`sprint` dan `crouch`) di Input Map. Pada script `Player.gd`, saya membuat variabel kecepatan yang dinamis (`current_speed`). Saat pemain menekan tombol *crouch*, kecepatan akan berkurang, dan saya menggunakan fungsi matematika `lerp()` (Linear Interpolation) untuk menurunkan nilai `height` pada `CollisionShape3D` serta posisi Y pada *node* kamera (Head) secara mulus. Hal sebaliknya terjadi saat tombol dilepas atau saat menekan tombol *sprint* (kecepatan bertambah).

### 2. Pick up Item, Inventory, & Coin HUD
Pemain dapat mengeksplorasi level untuk mengumpulkan item kolektibel berupa Koin.
* **Proses Implementasi:** Saya membuat *scene* koin menggunakan `MeshInstance3D` (bentuk silinder pipih) yang meng-*extend* class `Interactable`. Pada `RayCast3D` milik pemain, saya memodifikasi kodenya agar mengirimkan referensi *body* pemain saat fungsi `interact()` dipanggil. Jika item yang diambil adalah "Koin", *script* pemain akan menambahkan nilai variabel penghitung koin, lalu memanggil fungsi pada *node* `CanvasLayer` (HUD) untuk memperbarui teks UI di layar secara *real-time*. Setelah diambil, objek koin akan dihapus dari dunia 3D menggunakan `queue_free()`.

---

## Polishing 

### 1. Penambahan Rintangan Level
Untuk membuat permainan lebih menantang dan tidak sekadar berjalan di ruangan kosong, saya menambahkan rintangan *platforming*.
* **Proses Implementasi:** Saya memanfaatkan fitur *Constructive Solid Geometry* (CSG) bawaan Godot. Menggunakan kombinasi `CSGCombiner3D` dengan operasi *Subtraction* dan *Union*, saya membolongi lantai untuk membuat jurang (area *pit*) dan menyusun `CSGBox3D` sebagai *platform* pijakan yang mengharuskan pemain menggunakan kombinasi *sprint* dan *jump* untuk menyeberang. Jika pemain terjatuh ke jurang, *node* `Area3D` akan mendeteksi tabrakan dan mereset level menggunakan *Signals* `body_entered`.

### 2. Mesh Player Transparan (QoL Platforming)
Salah satu tantangan dalam game *First-Person Platformer* adalah pemain sulit melihat batas pijakan kaki mereka sendiri. Untuk mengatasi hal ini, saya memoles *mesh* karakter pemain agar sedikit transparan.
* **Proses Implementasi:** Pada *node* `MeshInstance3D` milik pemain, saya menambahkan **Transparency**.  Hasilnya, pemain tetap memiliki wujud fisik yang terlihat, namun tidak menutupi pandangan ke arah lantai saat harus melakukan lompatan presisi.

---

## 📚 Referensi

* **Godot Engine 4 Documentation - CharacterBody3D:** Digunakan sebagai acuan dasar pergerakan fisik karakter.
* **Godot Engine 4 Documentation - Ray-casting:** Acuan untuk mendeteksi objek *interactable* yang berada di depan kamera.
* **Godot Engine 4 Documentation - CSG:** Panduan untuk merancang level dasar menggunakan penggabungan dan pemotongan bentuk primitif 3D.
* **Modul Tutorial 7 Game Development:** Panduan utama dalam menyusun struktur *node* dan *script* dasar proyek.

---
