void main() {
  Map<String, String> person = {};

  person['first'] = 'Wildan';
  person['midle'] = "Firmani";
  person['last'] = "Quraisi";

  print(person);
  print(person.length);

  print(person['first']);

  person['last'] = 'Bahrul';
  print(person['last']);

  person.remove('midle');
  print(person);
}
