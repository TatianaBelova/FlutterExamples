import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_note/res/colors.dart';
import 'package:my_flutter_note/res/strings.dart';

class SimpleWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _row();
  }

  ListView _listViewBuilder() {
    return ListView.builder(
        itemBuilder: (context, index) {
          return Card(
              color: MyColors.cardBackground,
              elevation: 2,
              child: Text('$index'));
        },
        itemCount: 5);
  }

  Widget _listViewSeparated() {
    return ListView.separated(
        itemBuilder: (context, itemIndex) {
          return ListTile(
              leading: Icon(Icons.info_outline, size: 30),
              title: Text('$itemIndex'),
              trailing: Icon(Icons.favorite_border));
        },
        separatorBuilder: (context, itemIndex) {
          return Divider(color: Colors.deepPurple, height: 1);
        },
        itemCount: 5);
  }

  _listView() {
    return ListView(
        children: [
          Text(Strings.lorem),
      Container(
        color: Colors.green,
        width: 80,
        height: 80,
        child: Text('String'),
      ),
      _simpleImage(),
      Icon(Icons.info_outline, size: 30),
      CupertinoButton(child: Text('Press me'), color: Colors.teal)
    ]);
  }

  _simpleImage() {
    return Image.network('https://placeimg.com/640/480/nature');
  }

  _expandedImage() {
    return Row(
      children: [
        Expanded(
          child: Image.network(
            'https://placeimg.com/640/480/nature',
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent loadingProgress) {
              if (loadingProgress == null) return child;
              return CircularProgressIndicator();
            },
            errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
              return Text('😢');
            },
          ),
        ),
      ],
    );
  }

  _row() {
    return Row(
      children: <Widget>[
        Icon(Icons.ac_unit, size: 60,),
        Icon(Icons.ac_unit, size: 100,),
        Icon(Icons.ac_unit, size: 40,),
        Icon(Icons.ac_unit)
      ],
    );
  }

  _column() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.ac_unit, size: 60,),
        Icon(Icons.ac_unit, size: 100,),
        Icon(Icons.ac_unit, size: 40,),
        Icon(Icons.ac_unit)
      ],
    );
  }
}

class MyListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListView();
  }
}

class _ListView extends State<MyListView> {
  String buttonText = 'Press me';
  bool onInfoTapped = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          color: Colors.green,
          width: 80,
          height: 80,
          child: Text('String'),
        ),
        Image.network('https://via.placeholder.com/600/92c952',
            width: 100, height: 100),
        GestureDetector(
            onTap: () {
              setState(() {
                onInfoTapped = !onInfoTapped;
              });
            },
            child:
                Icon(onInfoTapped ? Icons.info_outline : Icons.info, size: 30)),
        FlatButton(
            child: Text(buttonText),
            color: Colors.teal,
            onPressed: () {
              setState(() {
                buttonText = 'Was pressed';
              });
            })
      ],
    );
  }
}
