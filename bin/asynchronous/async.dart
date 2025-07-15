Future<void> main() async {
  print('1. Mulai');
  String hasil = await tunggu();
  print(hasil);
  print('3. Selesai');
}

Future<String> tunggu() async {
  await Future.delayed(Duration(seconds: 1));
  return '2. Selesai setelah 1 detik';
}
