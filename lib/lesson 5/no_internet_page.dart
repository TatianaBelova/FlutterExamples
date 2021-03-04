import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

enum InternetState { connected, notConnected }

class NoInternetPage extends StatefulWidget {
  final void Function() haveInternetAction;

  NoInternetPage({@required this.haveInternetAction});

  @override
  State<StatefulWidget> createState() => NoInternetPageState();
}


class NoInternetPageState extends State<NoInternetPage> {
  var internetListener;

  final TextStyle regularTextStyle = TextStyle(
      fontSize: 15,
      color: Color.fromARGB(255, 60, 60, 60));

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _textNoInternet(),
            _rowUpdate()
          ],
        ),
      ),
    );
  }

  Widget _textNoInternet() {
    return Center(
      child: Text(
          "Подключение к интернету отсутствует",
          textAlign: TextAlign.center, style: regularTextStyle),
    );
  }

  Widget _rowUpdate() {
    return RaisedButton(
      onPressed: _onUpdateTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _rowUpdateIcon(),
          Text(
              "Обновить страницу",//Strings.refreshPage,
              style: regularTextStyle
          ),
        ],
      ),
    );
  }

  Padding _rowUpdateIcon() {
    return Padding(
      padding: const EdgeInsets.only(right: 9.0),
      child: Icon(Icons.refresh, color: Color.fromARGB(255, 118, 102, 101)),
    );
  }

  _onUpdateTap() {
    internetListener = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        widget.haveInternetAction();
      }
    });
  }

  @override
  void dispose() {
    internetListener?.cancel();
    super.dispose();
  }
}