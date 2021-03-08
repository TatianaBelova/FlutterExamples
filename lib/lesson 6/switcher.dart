import 'package:flutter/material.dart';

class Switcher extends StatefulWidget {
  final bool selected;
  final ValueChanged<bool> onTap;

  Switcher({this.selected = false, this.onTap});

  @override
  _SwitcherState createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher>
    with SingleTickerProviderStateMixin {
  final _bloc = SwitchBloc();

  @override
  void initState() {
    super.initState();
    _bloc.controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _bloc.offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _bloc.controller,
      curve: Curves.linear,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _bloc.onSwitchTap(widget.selected, widget.onTap),
      child: Stack(children: [
        ValueListenableBuilder(
          valueListenable: _bloc.backgroundColor,
          builder: (context, value, child) => Container(
            height: 24.0,
            width: 48.0,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                color: value,
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
        SlideTransition(
          position: _bloc.offsetAnimation,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: ValueListenableBuilder(
              valueListenable: _bloc.circleColor,
              builder: (context, value, child) => Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(color: value, shape: BoxShape.circle),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}


class SwitchBloc {
  AnimationController controller;
  Animation<Offset> offsetAnimation;
  final backgroundColor = ValueNotifier(Colors.white);
  final circleColor = ValueNotifier(Colors.blue.shade500);

  void onSwitchTap(bool selected, Function onTap) {
    if (!selected) {
      controller.forward();
      circleColor.value = Colors.white;
      backgroundColor.value = Colors.blue.shade500;
    } else {
      controller.reverse();
      circleColor.value = Colors.blue.shade500;
      backgroundColor.value = Colors.white;
    }
    onTap(!selected);
  }

  void dispose() {
    controller.dispose();
  }
}