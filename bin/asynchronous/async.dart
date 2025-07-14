Future<void> main() async {
  //Contoh Penggunaan Sinkron.
  print('1. Mulai');
  print(tunggu());
  print('3. Selesai');

  //Asinkron
  print('1. Mulai');
  String hasil = await dentek();
  print(hasil);
  print('3. Selesai');
}

String tunggu() {
  return '2. Tunggu selesai';
}

Future<String> dentek() async {
  await Future.delayed(Duration(seconds: 3));
  return '2. Selesai setelah 1 detik';
}
