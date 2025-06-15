void main() {
  //Deklarasi list dengan code yang lebih explisit
  List<String> person = ['Wildan', 'Talita', 'Rani'];
  print(person);

  //Deklarasi list dengan code yang lebih dynamic
  var orang = <String>['Ubet', 'Bahrul', 'Gufron'];
  print(orang);

  //Menampilkan jumlah data yang ada di list
  print(person.length);

  //menampilkan data list tertentu
  print(person[0]);

  //Mengubah data list tertentu
  person[0] = 'Rohmah';
  print(person[0]);

  //Mengahapus data list tertentu
  person.removeAt(1);
  print(person);
}
