//Introduction to Dart

//"Daripada saya nulis ulang class Person di main.dart, lebih baik saya import dari file lain agar rapi dan bisa dipakai berulang."
//import 'package:test/test.dart';

void main() async {
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
  var lulus = Lulus(name, age, 2025);

  // Memanggil method introduce()
  orang1.introduce();
  lulus.describe(); // dari Lulus

  // Contoh: pilih planet
  Planet planetKamu = Planet.earth;

  // Cetak informasi
  print("Nama planet: ${planetKamu.name}");
  print("Jenis: ${planetKamu.type}");
  print("Jumlah bulan: ${planetKamu.moons}");
  print("Punya cincin: ${planetKamu.hasRings}");
  print("Termasuk planet raksasa? ${planetKamu.isGiant ? 'Ya' : 'Tidak'}");

  await belajar("Dart");
  await belajar("Flutter");
}

//untuk membuat Comments / keterangan gunakan ini //

// Class induk (Parent Class)
class Person {
  String name;
  int age;

  // Constructor untuk class Person
  Person(this.name, this.age);

  // Method untuk memperkenalkan diri
  void introduce() {
    print('Halo, nama saya $name dan saya berumur $age tahun.');
  }
}

// Class turunan (Child Class) dari Person
class Lulus extends Person {
  int tahunLulus;

  // Constructor Lulus menerima name, age, dan tahunLulus
  Lulus(super.name, super.age, this.tahunLulus);

  // Method untuk menampilkan informasi kelulusan
  void describe() {
    print('Saya lulus pada tahun $tahunLulus.');
  }
}

// Enum untuk jenis planet
enum PlanetType {
  terrestrial, // planet berbatu seperti Bumi, Mars
  gas, // planet gas seperti Jupiter, Saturnus
  ice, // planet es seperti Uranus, Neptunus
}

// Enum untuk daftar planet lengkap beserta datanya
enum Planet {
  mercury(type: PlanetType.terrestrial, moons: 0, hasRings: false),
  venus(type: PlanetType.terrestrial, moons: 0, hasRings: false),
  earth(type: PlanetType.terrestrial, moons: 1, hasRings: false),
  mars(type: PlanetType.terrestrial, moons: 2, hasRings: false),
  jupiter(type: PlanetType.gas, moons: 79, hasRings: true),
  saturn(type: PlanetType.gas, moons: 83, hasRings: true),
  uranus(type: PlanetType.ice, moons: 27, hasRings: true),
  neptune(type: PlanetType.ice, moons: 14, hasRings: true);

  // Constructor tetap
  const Planet({
    required this.type,
    required this.moons,
    required this.hasRings,
  });

  // Properti milik setiap planet
  final PlanetType type; // jenis planet
  final int moons; // jumlah bulan
  final bool hasRings; // punya cincin atau tidak

  // Getter untuk menentukan apakah planet ini planet raksasa
  bool get isGiant => type == PlanetType.gas || type == PlanetType.ice;
}

//Async
Future<void> belajar(String nama) async {
  print("Mulai belajar $nama");
  await Future.delayed(Duration(seconds: 2));
  print("Selesai belajar $nama");
}
