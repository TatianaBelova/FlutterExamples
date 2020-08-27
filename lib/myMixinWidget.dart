import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyMixinWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyMixinWidgetState();
}

class _MyMixinWidgetState extends State with MyLoader, MyProgress {
  // мы можем указать столько миксинов, сколько нам это нужно

  @override
  Widget build(BuildContext context) {
    if (!_isLoad) return loader();
    if (!_isProgress) return progress();
    return Center(child: Text('Complete'));
  }
}

mixin MyLoader on State {
  // on State - указывает что класс к которому будет применяться данный миксин,
  // должен быть унаследован от супер класса State.
  bool _isLoad = false;

  Widget loader() {
    return Center(
      child: FlatButton(
          child: CircularProgressIndicator(),
          onPressed: () => setState(() {
                _isLoad = true;
              })),
    );
    // благодаря on State - мы можем указать на вызов метода setState((){})
    // для того чтобы вызвать обновление родительского виджета
  }
}
mixin MyProgress on State, MyLoader {
  // в этот миксин мы добавили зависимость от миксина MyLoader,
  // т.е. без него нельзя будет воспользоваться этим миксином в одиночку
  // и мы можем обращаться к параметру: _isLoad
  bool _isProgress = false;

  Widget progress() {
    if (!_isLoad) return Text('Error load');
    return Center(
      child: FlatButton(
          child: Text('Progress: 50%'),
          onPressed: () => setState(() {
                _isProgress = true;
              })),
    );
  }
}
