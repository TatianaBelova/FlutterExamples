import 'package:flutter/material.dart';
import 'package:my_flutter_note/res/strings.dart';

class BluePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      child: ListView(
        children: [
//          for (var i = 0; i < 10000; i++) _buildLineWidget(i), //90000 widgets in this one frame that were created
          for (var i = 0; i < 10000; i++) LineWidget(i),//we are creating 10000 widgets
        ],
      ),
    );
  }

  Widget _buildLineWidget(int i) {
    var line = Strings.loremIpsum[i % Strings.loremIpsum.length];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      child: Row(
        children: <Widget>[
          Container(
            color: Colors.black,
            child: SizedBox(
              width: 30,
              height: 30,
              child: Center(
                child: Text(
                  line.substring(0, 1),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(line, softWrap: false),
          )
        ],
      ),
    );
  }
}

class LineWidget extends StatelessWidget {
  int i;
  LineWidget(this.i);

  @override
  Widget build(BuildContext context) {
    var line = Strings.loremIpsum[i % Strings.loremIpsum.length];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      child: Row(
        children: <Widget>[
          Container(
            color: Colors.black,
            child: SizedBox(
              width: 30,
              height: 30,
              child: Center(
                child: Text(
                  line.substring(0, 1),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(line, softWrap: false),
          )
        ],
      ),
    );
  }
}
