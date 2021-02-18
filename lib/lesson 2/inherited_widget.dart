import 'package:flutter/material.dart';

class MyInheritedWidget extends InheritedWidget {
  int accountId;

  MyInheritedWidget(this.accountId, Widget child) : super(child: child);

  static MyInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return accountId != oldWidget.accountId;
  }
}


class MyInheritedPage extends StatelessWidget {
  int accountId;

  MyInheritedPage(this.accountId);

  Widget build(BuildContext context) {
    return MyInheritedWidget(
      accountId,
      MyWidget(),
    );
  }
}


class MyWidget extends StatelessWidget {
  MyWidget();

  Widget build(BuildContext context) {
    return MyOtherWidget();
  }
}

class MyOtherWidget extends StatelessWidget {
  MyOtherWidget();

  @override
  Widget build(BuildContext context) {
    final myInheritedWidget = MyInheritedWidget.of(context);
    return Text('${myInheritedWidget.accountId}');
  }
}
