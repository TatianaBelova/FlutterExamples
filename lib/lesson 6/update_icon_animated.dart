import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateIconAnimated extends StatefulWidget {
  final Function() onFinishAnimation;

  UpdateIconAnimated({this.onFinishAnimation});
  @override
  State<StatefulWidget> createState() => UpdateIconAnimatedState();
}

class UpdateIconAnimatedState extends State<UpdateIconAnimated> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final duration = const Duration(milliseconds: 23000);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration)..forward();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: refreshAnimation(),
      child: refreshIcon,
    );
  }

  Animation<double> refreshAnimation() {
    return Tween(begin: 0.0, end: pi * 7).animate(_controller)
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed)
          widget.onFinishAnimation?.call();
      });
  }

  StatelessWidget refreshIcon = Icon(
      Icons.refresh,
      color: Colors.green.shade600
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}