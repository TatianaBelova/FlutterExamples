import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SimpleIsolate extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircularProgressIndicator(),
          RaisedButton(
            child: Text('start'),
            onPressed: () async {
              final sum = computationallyExpensiveTask(1000000000);
//              final sum = await compute(computationallyExpensiveTask, 1000000000);
              print(sum);
            },
          )
        ],
      ),
    );
  }
}


int computationallyExpensiveTask(int value) {
  var sum = 0;
  for (var i = 0; i <= value; i++) {
    sum += i;
  }
  print('finished');
  return sum;
}
