void main() {
  var person = Person();
  person.behavior();
}

class Person {
  String name = 'Wildan';

  void behavior() {
    print('$name, Is Run');
  }
}
