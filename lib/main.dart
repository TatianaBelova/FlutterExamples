import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'lesson 4/coins/widgets/coins_page.dart';
import 'lesson 5/bloc_pattern/coins_pattern_page.dart';

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
        body: SafeArea(child: CoinsPatternPage()),
      ),
    );
  }
}
