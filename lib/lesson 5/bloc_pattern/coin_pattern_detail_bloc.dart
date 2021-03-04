import 'dart:async';

import 'package:my_flutter_note/lesson%204/coins/models/coin_event.dart';
import 'package:my_flutter_note/lesson%205/repository.dart';

import '../no_internet_page.dart';

class CoinPatternDetailBloc {
  List<CoinEvent> _listEvents;
  Repository _repository;
  String coinId;

  final _outInternetStateStream = StreamController<InternetState>.broadcast();
  final _outNavigatorBack = StreamController.broadcast();
  final _outGetEvents = StreamController.broadcast();
  final _inTapOnBackButton = StreamController.broadcast();
  final _inHaveInternet = StreamController<InternetState>.broadcast();

  Stream get internetState => _outInternetStateStream.stream;
  Stream get navigatorBack => _outNavigatorBack.stream;
  Stream get streamEvents => _outGetEvents.stream;
  StreamSink get tapOnBackButton => _inTapOnBackButton;
  StreamSink get haveInternet => _inHaveInternet.sink;

  CoinPatternDetailBloc(this.coinId, this._repository) {
    _inTapOnBackButton.stream.listen(_tapOnBackButton);
    _inHaveInternet.stream.listen((state) =>
        _changeInternetAction(InternetState.connected));
  }

  Future<void> getEvents() async {
    _listEvents = await _repository.loadCoinEvents(coinId);
    if (_listEvents != null) {
      return _outGetEvents.sink.add(_listEvents);
    } else {
      return _changeInternetAction(InternetState.notConnected);
    }
  }

  void _changeInternetAction(data) {
    _outInternetStateStream.sink.add(data);
  }

  void _tapOnBackButton(event) {
    _outNavigatorBack.sink.add(null);
  }

  void dispose() {
    _outInternetStateStream.close();
    _outNavigatorBack.close();
    _outGetEvents.close();
    _inTapOnBackButton.close();
    _inHaveInternet.close();
  }
}