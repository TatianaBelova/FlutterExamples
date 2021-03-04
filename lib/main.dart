import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'file:///C:/Users/tatiana/StudioProjects/FlutterExamples/lib/lesson%205/bloc_library/bloc/observer.dart';
import 'file:///C:/Users/tatiana/StudioProjects/FlutterExamples/lib/lesson%205/bloc_library/presentation/coins_bloc_library_page.dart';

import 'lesson 4/coins/widgets/coins_page.dart';
import 'lesson 5/bloc_library/bloc/coin_bloc.dart';
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
        appBar: AppBar(
          title: Text('Flutter examples'),
        ),
        body: SafeArea(child:
            CoinsPatternPage()
        // BlocProvider(
        //     create: (context) => CoinBloc(),
        //     child: CoinsBlocLibraryPage()),
        ),
      ),
    );
  }
}
