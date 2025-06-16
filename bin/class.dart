// Deklarasi kelas Person
class Person {
  // Field data (property) dengan nilai default
  String name = 'Wildan'; // Nama default
  String? address; // Alamat, boleh null (nullable)
  final String country =
      'Lumajang'; // Negara, bersifat final (tidak bisa diubah)

  // Method tanpa return value, hanya mencetak ucapan
  void keynote() {
    print('Assalamualaikum $name');
  }

  // Method dengan return value berupa String
  String greet() {
    return 'Bagaimana kabarmu $name';
  }

  // Method dengan parameter dan mencetak sapaan
  void hello(String you) {
    print('Hallo $you, nama saya $name');
  }

  // Method dengan expression body (bentuk singkat)
  void os() => print('Linux');

  // Method dengan expression body dan return value
  String distro() => 'Ubuntu';
}

// Fungsi utama (titik masuk program)
void main() {
  // Membuat objek dari kelas Person
  Person person = Person();

  // Menampilkan nama awal (default)
  print(person.name);

  // Mengubah nilai properti name
  person.name = 'Bahrul';

  // Menampilkan nilai properti address (masih null)
  print(person.address);

  // Memberikan nilai ke properti address
  person.address = 'Jakarta';

  // Menampilkan nilai final country
  print(person.country);

  // Memanggil method keynote()
  person.keynote();

  // Menampilkan hasil dari method greet()
  print(person.greet());

  // Memanggil method hello() dengan parameter
  person.hello('Ubet');

  // Memanggil method os() (expression body)
  person.os();

  // Menampilkan hasil dari method distro()
  print(person.distro());
}
