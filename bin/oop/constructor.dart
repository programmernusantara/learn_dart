void main() {
  var teacher1 = Teacher('Wildan', 1500.0000);
  teacher1.info();

  var teacher2 = Teacher('Bahrul', 1000.000);
  teacher2.info();
}

class Teacher {
  String? name;
  double? salary;

  Teacher(this.name, this.salary);

  void info() {
    print('Name: $name');
    print('Salary: $salary');
  }
}
