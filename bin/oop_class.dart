void main() {
  //Create object car
  Car myCarBrand = Car();
  myCarBrand.go();
}

// Class
class Car {
  // Property
  String bran = "Toyota";
  int speed = 0;

  //Method
  void go() {
    print('Top speed car: $bran. with speed: $speed.');
  }
}
