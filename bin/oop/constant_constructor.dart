void main() {
  var person = const ('Wildan', 20);
  print(person);
}

class Person {
  final String name;
  final int age;

  const Person(this.name, this.age);
}
