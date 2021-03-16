import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - kToolbarHeight - kBottomNavigationBarHeight,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.greenAccent,
        ),
      ),
    );
  }
}
