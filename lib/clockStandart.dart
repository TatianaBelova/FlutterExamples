import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_note/res/colors.dart';

class ClockStandart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Wrap(children: [
                Container(
                  padding: const EdgeInsets.only(right: 10.0),
                  margin: const EdgeInsets.only(right: 5.0),
                  color: MyColors.lightBrown,
                  width: 30,
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15.0),
                  color: MyColors.lightBrown,
                  width: 30,
                  height: 8,
                ),
              ]),
              Container(
                color: MyColors.lightBrown,
                width: 30,
                height: 8,
              )
            ],
          ),
          ClockWidget()
        ],
      ),
    );
  }
}

class ClockWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClockWidget();
}

class _ClockWidget extends State<ClockWidget> with TickerProviderStateMixin {

  DateTime date;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) => {setState(() {})});
  }

  @override
  Widget build(BuildContext context) {
    date = DateTime.now();
    return Container(
      decoration: BoxDecoration(
        color: MyColors.darkBrown,
        border: Border.all(color: MyColors.darkBrown, width: 10.0),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _minute(date),
          _second(date)
        ],
      ),
    );
  }

  Widget _minute(DateTime date) {
    return Transform.translate(
      offset: const Offset(-2.0, 0.0),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: MyColors.lightBrown,
          border: Border.all(color: MyColors.lightBrown, width: 10.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Center(
            child: Text(
              date.minute < 10
                  ? '0${date.minute.toString()}'
                  : date.minute.toString(),
              style: TextStyle(color: Colors.white, fontSize: 50),
            )),
      ),
    );
  }

  Widget _second(DateTime date) {
    return Transform.translate(
      offset: const Offset(2.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.lightBrown,
          border: Border.all(color: MyColors.lightBrown, width: 10.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        width: 100,
        height: 100,
        child: Center(
            child: Text(
              date.second < 10
                  ? '0${date.second.toString()}'
                  : date.second.toString(),
              style: TextStyle(color: Colors.white, fontSize: 50),
            )),
      ),
    );
  }
}












//    animationController = new AnimationController(
//      duration: const Duration(milliseconds: 500),
//      vsync: this,
//    )..repeat();

//    rotateX = new Tween<double>(
//      begin: .0,
//      end: 1.0,
//    ).animate(new CurvedAnimation(
//      parent: animationController,
//      curve: new Interval(.0, 0.5),
//    ));
//    rotateY = new Tween<double>(
//      begin: .0,
//      end: 1.0,
//    ).animate(new CurvedAnimation(
//      parent: animationController,
//      curve: new Interval(1 / 3, 2 / 3),
//    ));
//    rotateZ = new Tween<double>(
//      begin: .0,
//      end: 1.0,
//    ).animate(new CurvedAnimation(
//      parent: animationController,
//      curve: new Interval(.0, 1.0),
//    ));


//          AnimatedBuilder(
//            animation: animationController,
//            child: Transform.translate(
//              offset: const Offset(2.0, 0.0),
//              child: Container(
//                decoration: BoxDecoration(
//                  color: MyColors.lightBrown,
//                  border: Border.all(color: MyColors.lightBrown, width: 10.0),
//                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                ),
//                width: 100,
//                height: 100,
//                child: Center(
//                    child: Text(
//                  date.second < 10
//                      ? '0${date.second.toString()}'
//                      : date.second.toString(),
//                  style: TextStyle(color: Colors.white, fontSize: 50),
//                )),
//              ),
//            ),
//            builder: (BuildContext context, Widget _widget) {
//              return Transform(
//                transform: new Matrix4.rotationX(rotateX.value * math.pi)
//                  ..multiply(new Matrix4.rotationY(rotateY.value * math.pi))
//                  ..multiply(new Matrix4.rotationZ(rotateZ.value * math.pi)),
//                alignment: Alignment.center,
//                child: _widget,
//              );
//            },
//          ),
