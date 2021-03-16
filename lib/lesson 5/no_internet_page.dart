import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter_note/lesson%206/switcher.dart';
import 'package:my_flutter_note/lesson%206/update_icon_animated.dart';

enum InternetState { connected, notConnected }

class NoInternetPage extends StatefulWidget {
  final void Function() haveInternetAction;

  const NoInternetPage({@required this.haveInternetAction});

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

  TextStyle regularTextStyle =
      const TextStyle(fontSize: 15, color: Color.fromARGB(255, 60, 60, 60));

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextNoInternet(textStyle: regularTextStyle),
            RowUpdate(),
            const SizedBox(height: 100),
            Row(
              children: [
                Text('Включить Bluetooth '),
                const SizedBox(width: 15),
                ValueListenableBuilder(
                  valueListenable: _bloc.switchBluetoothNotifier,
                  builder: (_, value, __) => Switcher(
                    selected: value,
                    onTap: (bool newValue) async {
                      await _bloc.switchBluetooth();
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text('Включить Wifi'),
                const SizedBox(width: 15),
                ValueListenableBuilder(
                  valueListenable: _bloc.switchWifiNotifier,
                  builder: (_, value, __) => Switcher(
                    selected: value,
                    onTap: (bool newValue) async {
                      await _bloc.switchWifi();
                    },
                  ),
                ),
              ],
            ),
            // FlutterLogoAnimated()
          ],
        ),
      ),
    );
  }
}

class TextNoInternet extends StatelessWidget {
  final textStyle;

  TextNoInternet({this.textStyle});

  @override
  Widget build(BuildContext context) => Center(
        child: Text("Подключение к интернету отсутствует",
            textAlign: TextAlign.center, style: textStyle),
      );
}

class RowUpdate extends StatelessWidget {
  final bloc;
  final textStyle;

  RowUpdate({this.bloc, this.textStyle});

  @override
  Widget build(BuildContext context) => RaisedButton(
        onPressed: bloc.onUpdateTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RowUpdateIcon(bloc: bloc),
            Text("Обновить страницу", style: textStyle),
          ],
        ),
      );
}

class RowUpdateIcon extends StatelessWidget {
  final bloc;

  RowUpdateIcon({this.bloc});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 9.0),
        child: ValueListenableBuilder(
            valueListenable: bloc.updateIconNotifier,
            builder: (_, value, __) {
              return value
                  ? UpdateIconAnimated(
                      onFinishAnimation: bloc.onFinishAnimation)
                  : Icon(Icons.refresh, color: Colors.green.shade600);
            }),
      );
}

class NoInternetPageBloc {
  static const platform = const MethodChannel('flutterExamples/bluetooth');

  final ValueNotifier updateIconNotifier = ValueNotifier<bool>(false);
  final ValueNotifier switchBluetoothNotifier = ValueNotifier<bool>(false);
  final ValueNotifier switchWifiNotifier = ValueNotifier<bool>(false);
  final Function() hasInternet;

  NoInternetPageBloc({this.hasInternet});

  Future<void> _checkConnection() async {
    var state = await Connectivity().checkConnectivity();
    while (state == ConnectivityResult.none) {
      await Future.delayed(const Duration(milliseconds: 500));
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

  Future<String> switchBluetooth() async {
    try {
      final String result = await platform.invokeMethod(
          !switchBluetoothNotifier.value ? 'onBluetooth' : 'offBluetooth');
      switchBluetoothNotifier.value = !switchBluetoothNotifier.value;
      print(result);
      return result;
    } on PlatformException catch (e) {
      print('Ошибка платформы: ${e.message}');
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> switchWifi() async {
    try {
      await platform.invokeMethod('switchWifi');
      switchWifiNotifier.value = !switchWifiNotifier.value;
    } on PlatformException catch (e) {
      print('Ошибка платформы: ${e.message}');
    } catch (e) {
      print(e);
    }
  }
}
