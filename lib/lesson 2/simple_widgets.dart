import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_flutter_note/res/colors.dart';
import 'package:my_flutter_note/res/strings.dart';
class SimpleWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _row();
  }

  _row() {
    return Row(
      children: <Widget>[
        const Icon(Icons.ac_unit, size: 60,),
        const Icon(Icons.ac_unit, size: 100,),
        const Icon(Icons.ac_unit, size: 40,),
        const Icon(Icons.ac_unit)
      ],
    );
  }

  _column() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(Icons.ac_unit, size: 60,),
        const Icon(Icons.ac_unit, size: 100,),
        const Icon(Icons.ac_unit, size: 40,),
        const Icon(Icons.ac_unit)
      ],
    );
  }

  _listView() {
    return ListView(
        children: [
          Text(Strings.lorem),
      Container(
        color: Colors.green,
        width: 80,
        height: 80,
        child: const Text('String'),
      ),
      _simpleImage(),
          const Icon(Icons.info_outline, size: 30),
      CupertinoButton(child: const Text('Press me'), color: Colors.teal)
    ]);
  }

  _simpleImage() {
    return Image.asset('qr_telegram.png');
  }

  _expandedImage() {
    return Row(
      children: [
        Image.network(
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
      ],
    );
  }

  ListView _listViewBuilder() {
    return ListView.builder(
        itemBuilder: (context, index) {
          return Card(
              color: MyColors.cardBackground,
              elevation: 2,
              child: Text('$index'));
        },
        itemCount: 50);
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
          return const Divider(color: Colors.deepPurple, height: 1);
        },
        itemCount: 5);
  }

  Widget _threeList() {
    final random = Random();

    return ListView(children: [
      GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 4,
        children: List.generate(
            random.nextInt(15) + 1,
            (_) => Container(
                  color: Colors.teal[100],
                )),
      ),
      GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 4,
        children: List.generate(
            random.nextInt(15) + 1,
            (_) => Container(
                  color: Colors.yellow[100],
                )),
      ),
      GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 4,
        children: List.generate(
            random.nextInt(15) + 1,
            (_) => Container(
                  color: Colors.red[100],
                )),
      )
    ]);
  }
  
  Widget _stack() {
    return Stack(
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          color: Colors.red,
        ),
        Container(
          width: 90,
          height: 90,
          color: Colors.green,
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.blue,
        ),
      ],
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyStatefulWidgetState();
  }
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool onInfoTapped = false;
  final notifier = ValueNotifier<String>('Press me');


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.green,
            width: 300,
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text('String', style: const TextStyle(color: Colors.white),),
            ),
          ),
          Image.network('https://placeimg.com/640/480/nature',
              width: 300, height: 300),
          GestureDetector(
              onTap: () {
                setState(() {
                  onInfoTapped = !onInfoTapped;
                });
              },
              child:
                  Icon(onInfoTapped ? Icons.info_outline : Icons.info, size: 30)),
          const SizedBox(height: 200,),
          ValueListenableBuilder(
            valueListenable: notifier,
            builder: (_, value, __) => FlatButton(
                child: Text(value, style: const TextStyle(color: Colors.white)),
                color: Colors.teal,
                onPressed: () {
                  notifier.value = 'New Button Text';
                }),
          ),
        ],
      ),
    );
  }
}