import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'lesson 5/bloc_pattern/coins_pattern_page.dart';

void main() {
  // Bloc.observer = Observer();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Flutter examples'),
        ),
        body: SafeArea(child:
            CoinsPatternPage()
        ),
      ),
    );
  }
}

// BlocProvider(
//     create: (context) => CoinBloc(),
//     child: CoinsBlocLibraryPage()),