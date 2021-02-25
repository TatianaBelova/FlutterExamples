import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'lesson 3/flights_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter examples'),
        ),
        body: SafeArea(child: FlightsWidget()),
      ),
    );
  }
}
