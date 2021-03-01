import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.greenAccent,
        ),
      ),
    );
  }
}
