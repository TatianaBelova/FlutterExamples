import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:my_flutter_note/clockStandart.dart';
import 'package:my_flutter_note/inheritedWidget.dart';
import 'package:my_flutter_note/simpleWidgets.dart';
import 'dart:async';
import 'dart:math';

import 'notes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
//        appBar: AppBar(title: Text('Notes'),),
        body: SafeArea(
            child: SimpleWidgets()),
      ),
    );
  }
}