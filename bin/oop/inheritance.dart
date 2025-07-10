void main() {
  var car = Brand();
  car.brand = 'Honda';
  car.model = 'Hrv';
  car.year = 2025;
  car.price = 1000000;
  car.start();
  car.details();
}

class Car {
  String? brand;

  void start() {
    print('Running');
  }
}

class Brand extends Car {
  late String model;
  late int year;
  late double price;

  void details() {
    print('Brand: $brand, Model: $model, Years: $year, Price: $price');
  }
}
