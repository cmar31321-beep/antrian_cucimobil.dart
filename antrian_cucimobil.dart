import 'dart:io';

void main() {
  bool jalan = true;

  Map<String, dynamic> posa = {'plat': null};
  Map<String, dynamic> posb = {'plat': null};
  Map<String, dynamic> posc = {'plat': null};

  List<String> waitinglist = [];

  void tampilmenu() {
    print('\n===================================');
    print('          CarWash & Clean        ');
    print('===================================');
    print('1. Tambah Waiting List');
    print('2. Lihat Waiting List');
    print('3. Lihat Pos');
    print('4. Selesaikan Pos');
    print('5. Keluar Dari Aplikasi');
    print('===================================');
    stdout.write('Pilih Menu (1/2/3/4/5) : ');
  }

  void tambahlist() {
    stdout.write('Plat Kendaraan : ');
    String? plat = stdin.readLineSync();

    if (plat == null || plat.trim().isEmpty) {
      print('Nomor plat tidak boleh kosong!');
      return;
    }

    // Jika pos a, pos b, pos c lagi kosong maka masuk ke a -> b -> c, selain itu ke waiting list
    if (posa['plat'] == null) {
      posa['plat'] = plat;
      print('Kendaraan $plat langsung masuk ke Pos A.');
    } else if (posb['plat'] == null) {
      posb['plat'] = plat;
      print('Kendaraan $plat langsung masuk ke Pos B.');
    } else if (posc['plat'] == null) {
      posc['plat'] = plat;
      print('Kendaraan $plat langsung masuk ke Pos C.');
    } else {
      waitinglist.add(plat);
      print('Semua Pos penuh. Kendaraan $plat dimasukkan ke Waiting List.');
    }
  }

  void lihatlist() {
    print('\n--- DAFTAR WAITING LIST ---');
    if (waitinglist.isEmpty) {
      print('Waiting list kosong.');
    } else {
      // Menggunakan perulangan for in untuk menampilkan waiting list
      int no = 1;
      for (var plat in waitinglist) {
        print('$no. Plat: $plat');
        no++;
      }
    }
  }

  void lihatpost() {
    print('\n--- STATUS POS SAAT INI ---');
    print('Pos A : ${posa['plat'] ?? 'Kosong'}');
    print('Pos B : ${posb['plat'] ?? 'Kosong'}');
    print('Pos C : ${posc['plat'] ?? 'Kosong'}');
  }

  void selesaikanpos() {
    lihatpost();
    stdout.write('Pilih Pos yang ingin diselesaikan (A / B / C): ');
    String? pilihanPos = stdin.readLineSync()?.toUpperCase();

    Map<String, dynamic>? targetPos;
    String namaPos = '';

    if (pilihanPos == 'A') {
      targetPos = posa;
      namaPos = 'Pos A';
    } else if (pilihanPos == 'B') {
      targetPos = posb;
      namaPos = 'Pos B';
    } else if (pilihanPos == 'C') {
      targetPos = posc;
      namaPos = 'Pos C';
    } else {
      print('Pilihan Pos Tidak Valid!');
      return;
    }

    // Cek dulu mobil di pos tersebut lalu print
    if (targetPos['plat'] == null) {
      print('$namaPos Sudah Kosong.');
      return;
    }

    print('Mobil dengan plat ${targetPos['plat']} di $namaPos telah selesai.');

    // Pos dikosongkan
    targetPos['plat'] = null;

    // Dari waiting list pertama pindah ke pos tersebut lalu print pos, dan waiting list pertama dihapus
    if (waitinglist.isNotEmpty) {
      String mobilBaru = waitinglist.removeAt(0);
      targetPos['plat'] = mobilBaru;
      print('Kendaraan $mobilBaru dari waiting list dipindahkan ke $namaPos.');
    } else {
      print('$namaPos sekarang kosong karena waiting list kosong.');
    }
  }

  void keluarApp() {
    print('Keluar Dari Aplikasi. Terima Kasih!');
    exit(0);
  }

  // Perbaikan loop while dan kondisi bernilai true
  while (jalan == true) {
    tampilmenu();
    String? pilihan = stdin.readLineSync();

    switch (pilihan) {
      case '1':
        tambahlist();
        break;
      case '2':
        lihatlist();
        break;
      case '3':
        lihatpost();
        break;
      case '4':
        selesaikanpos();
        break;
      case '5':
        keluarApp();
        break;
      default:
        print('Pilihan Tidak Valid, Silakan Masukkan Angka 1 Sampai 5.');
    }
  }
}