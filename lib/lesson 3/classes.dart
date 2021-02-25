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
  String _color;
  int _vinCode;

  String get carColor {
    return _color;
  }

  set carColor(String color) {
    this._color != null ? color : 'default black color';
  }

  ToyotaCar.corollaOnly() {
    this._color = 'Black';
    this._vinCode = 784643;
  }

  ToyotaCar.forAuris(String c, int v) {
    _color = c;
    _vinCode = v;
  }

  var frenchCars = ['Renault', 'Citroen'];

  Widget greeting(String userName, [String userEmail = 'someEmail']) =>
      Text('Hello, $userName + ${userEmail == null ? '' : userEmail}');

  void display() {
    print('Color: $_color VIN_CODE: $_vinCode');
    greeting('Name', 'Email');
  }

  String playerName(String name) => name ?? 'Guest';
}