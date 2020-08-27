import 'package:flutter/material.dart';

class MyInheritedWidget extends InheritedWidget {
  final int accountId;

  const MyInheritedWidget(this.accountId, Widget child) : super(child: child);

  static MyInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return accountId != oldWidget.accountId;
  }
}

class MyInheritedPage extends StatelessWidget {
  final int accountId;

  MyInheritedPage(this.accountId);

  Widget build(BuildContext context) {
    return MyInheritedWidget(
      accountId,
      const MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget();

  Widget build(BuildContext context) {
    return const MyOtherWidget();
  }
}

class MyOtherWidget extends StatelessWidget {
  const MyOtherWidget();

  @override
  Widget build(BuildContext context) {
    final myInheritedWidget = MyInheritedWidget.of(context);
    return Text('${myInheritedWidget.accountId}');
  }
}
