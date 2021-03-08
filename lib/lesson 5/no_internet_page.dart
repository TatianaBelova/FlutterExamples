import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_note/lesson%206/flutter_logo_animated.dart';
import 'package:my_flutter_note/lesson%206/switcher.dart';

import '../lesson 6/update_icon_animated.dart';

enum InternetState { connected, notConnected }

class NoInternetPage extends StatefulWidget {
  final void Function() haveInternetAction;

  NoInternetPage({@required this.haveInternetAction});

  @override
  State<StatefulWidget> createState() => NoInternetPageState();
}

class NoInternetPageState extends State<NoInternetPage> {
  NoInternetPageBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = NoInternetPageBloc(hasInternet: widget.haveInternetAction);
  }

  final TextStyle regularTextStyle =
      TextStyle(fontSize: 15, color: Color.fromARGB(255, 60, 60, 60));

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _textNoInternet(),
            _rowUpdate(),
            ValueListenableBuilder(
              valueListenable: _bloc.switchNotifier,
              builder: (_, value, __) => Switcher(
                selected: value,
                onTap: (bool newValue) {
                  _bloc.switchNotifier.value = newValue;
                },
              ),
            ),
            FlutterLogoAnimated()
          ],
        ),
      ),
    );
  }

  Widget _textNoInternet() {
    return Center(
      child: Text("Подключение к интернету отсутствует",
          textAlign: TextAlign.center, style: regularTextStyle),
    );
  }

  Widget _rowUpdate() {
    return RaisedButton(
      onPressed:  _bloc.onUpdateTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _rowUpdateIcon(),
          Text("Обновить страницу",
              style: regularTextStyle),
        ],
      ),
    );
  }

  Padding _rowUpdateIcon() {
    return Padding(
      padding: const EdgeInsets.only(right: 9.0),
      child: ValueListenableBuilder(
          valueListenable: _bloc.updateIconNotifier,
          builder: (_, value, __) {
            return value
                ? UpdateIconAnimated(onFinishAnimation:  _bloc.onFinishAnimation)
                : Icon(Icons.refresh, color: Colors.green.shade600);
          }),
    );
  }
}


class NoInternetPageBloc {
  final ValueNotifier updateIconNotifier = ValueNotifier<bool>(false);
  final ValueNotifier switchNotifier = ValueNotifier<bool>(false);
  final Function() hasInternet;

  NoInternetPageBloc({this.hasInternet});

  Future<void> _checkConnection() async {
    var state = await Connectivity().checkConnectivity();
    while (state == ConnectivityResult.none) {
      await Future.delayed(Duration(milliseconds: 500));
      state = await Connectivity().checkConnectivity();
    }
    hasInternet();
  }

  Future<void> onUpdateTap() async {
    if (!updateIconNotifier.value) {
      updateIconNotifier.value = !updateIconNotifier.value;
    }
    await _checkConnection();
  }

  onFinishAnimation() {
    updateIconNotifier.value = false;
  }
}