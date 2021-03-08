import 'package:flutter/material.dart';

class FlutterLogoAnimated extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FlutterLogoAnimatedState();
}

class _FlutterLogoAnimatedState extends State<FlutterLogoAnimated>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 0.2,
      end: 1,
    ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
        reverseCurve: Curves.decelerate));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Container(
        color: Colors.black12,
        height: 100,
        width: 100,
        child: FlutterLogo(
          size: 30,
        ),
      ),
    );
  }
}
