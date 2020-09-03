import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_note/clockStandart.dart';
import 'package:my_flutter_note/inheritedWidget.dart';
import 'package:my_flutter_note/myMixinWidget.dart';
import 'package:my_flutter_note/simpleWidgets.dart';
import 'dart:async';
import 'dart:math';

import 'notes.dart';

void main() => runApp(MyApp());

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

//import 'dart:isolate';
//void foo(var message){
//  print('execution from foo ... the message is :${message}');
//}
//void main() {
//  Isolate.spawn(foo,'Hello!!');
//  Isolate.spawn(foo,'Greetings!!');
//  Isolate.spawn(foo,'Welcome!!');
//  print('execution from main1');
//  print('execution from main2');
//  print('execution from main3');
//}


////Не работает этот код!
//StreamController controller = StreamController<String>.broadcast();
//// Прослушиваем поток
//StreamSubscription subscription = controller.stream.listen(print);
//StreamSubscription subscription1 = controller.stream.listen((event) {
//  print('Print 2! $event');
//});
//controller.add("Item1");
//controller.add("Item2");
//controller.add("Item3");
//subscription.cancel();
//subscription1.cancel();
//controller.close();
