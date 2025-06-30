void main() {
  //Create Object In Class Car With Name Object MyCar
  var myCar = Car();

  //Call Object In The Method
  myCar.finish;
  print(myCar.name);
}

// This is class
class Car {
  // This is prperty
  String name = "Wildan";

  // This is Method No Return Velue
  void finish() {
    //Display Text TO Console
    print("Finis");
  }

  //This is Method Value Supprot Return Value
  String start(String name) {
    //Return Value Method As Type Data String
    return name;
  }
}

void request() {}
