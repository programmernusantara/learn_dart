//"Daripada saya nulis ulang class Person di main.dart, lebih baik saya import dari file lain agar rapi dan bisa dipakai berulang."
//import 'package:test/test.dart';

void main() {
  // Bagian 1: Menampilkan ucapan selamat datang
  print('Hello World!');

  // Bagian 2: Pendefinisian variabel personal
  String name = 'Wildan FQ';
  int age = 20;
  int height = 170; // cm
  double weight = 60.5; // kg

  print(
    'Hai, nama saya $name. Umur saya $age tahun, berat badan saya $weight kg, dan tinggi saya $height cm.',
  );

  // Bagian 3: Percabangan untuk kategori usia
  if (age >= 21) {
    print('Anda sudah dewasa.');
  } else {
    print('Anda masih remaja.');
  }

  // Bagian 4: Perulangan daftar objek langit
  List<String> flybyObjects = ['Bulan', 'Bintang', 'Meteor', 'Roket'];
  print('\nBenda-benda yang melintas di langit:');
  for (final object in flybyObjects) {
    print('- $object');
  }

  // Bagian 5: Perulangan bulan dalam setahun
  print('\nDaftar bulan dalam setahun:');
  for (int month = 1; month <= 12; month++) {
    print('Bulan ke-$month');
  }

  // Bagian 6: Simulasi pertambahan usia tiap tahun hingga target usia
  int targetAge = 25;
  int currentYear = DateTime.now().year; // Misalnya 2025
  int simulatedAge = age;
  int simulatedYear = currentYear;

  print('\nSimulasi pertambahan usia setiap tahun:');
  while (simulatedAge < targetAge) {
    print('Tahun $simulatedYear - Usia: $simulatedAge tahun');
    simulatedAge++;
    simulatedYear++;
  }
  print('Tahun $simulatedYear, usia telah mencapai $simulatedAge tahun.');

  //Functions
  int fibonacci(int n) {
    if (n == 0 || n == 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
  }

  var result = fibonacci(5);
  print('Hasil fibonacci(5) adalah: $result');

  // Membuat objek dari class Person
  var orang1 = Person('Wildan', 20);
  var orang2 = Person('Aneska', 18);

  // Memanggil method introduce()
  orang1.introduce();
  orang2.introduce();
}

//untuk membuat Comments / keterangan gunakan ini //

// Ini class-nya
class Person {
  String name;
  int age;

  // Constructor: cara membuat objek Person
  Person(this.name, this.age);

  // Method: fungsi untuk memperkenalkan diri
  void introduce() {
    print('Halo, nama saya $name dan saya berumur $age tahun.');
  }
}
