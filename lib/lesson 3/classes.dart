import 'package:flutter/material.dart';

abstract class Car {
  void beep();
}

class Cars extends Car {
  String color;

  @override
  void beep() {
    print('Cars beep');
  }

  String engineType;

  Cars(this.engineType);

  void display() {
    print("Name: $engineType");
  }
}

class Toyota extends Cars {
  Toyota(String engineType) : super(engineType);

  void parents() {
    super.display();
  }
}

class ToyotaCar {
  String color;
  int vinCode;

  String get carColor {
    return color;
  }

  set carColor(String color) {
    this.color = color;
  }

  ToyotaCar.corollaOnly() {
    color = 'Black';
    vinCode = 784643;
  }

  ToyotaCar.forAuris(String c, int v) {
    color = c;
    vinCode = v;
  }

  var frenchCars = ['Renault', 'Citroen'];

  Widget greeting(String userName, [String userEmail = 'someEmail']) =>
      Text('Hello, $userName + ${userEmail == null ? '' : userEmail}');

  void display() {
    print('Color: $color VIN_CODE: $vinCode');
    greeting('Name', 'Email');
  }

  String playerName(String name) => name ?? 'Guest';
}

//
//extension FormatDate on String {
//  String formatDate() {
//    DateFormat rawDateFormat = DateFormat('yyyy-MM-dd');
//    DateFormat newDateFormat = DateFormat('dd.MM.yyyy');
//    DateTime rawDateTime = rawDateFormat.parse(this);
//    return newDateFormat.format(rawDateTime);
//  }
//}
