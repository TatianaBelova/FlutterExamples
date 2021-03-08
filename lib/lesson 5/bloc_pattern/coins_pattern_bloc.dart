import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_note/lesson%204/coins/models/coin.dart';
import 'package:my_flutter_note/lesson%205/repository.dart';

import '../no_internet_page.dart';
import 'coin_pattern_detail_page.dart';

class CoinsPatternBloc {
  List<Coin> _listItems;
  Repository _repository;

  ValueNotifier startLoadingNotifier = ValueNotifier<bool>(false);
  ValueNotifier colorNotifier = ValueNotifier<Color>(Colors.transparent);

  final _outInternetStateStream = StreamController<InternetState>.broadcast();
  final _outNavigateTo = StreamController.broadcast();
  final _outGetCoins = StreamController.broadcast();
  final _inTapOnItem = StreamController<Coin>.broadcast();
  final _inHaveInternet = StreamController<InternetState>.broadcast();

  Stream get internetState => _outInternetStateStream.stream;
  Stream get navigateTo => _outNavigateTo.stream;
  Stream get streamCoins => _outGetCoins.stream;
  StreamSink get tapOnItem => _inTapOnItem.sink;
  StreamSink get haveInternet => _inHaveInternet.sink;

  CoinsPatternBloc(this._repository) {
    _inTapOnItem.stream.listen(_tapOnItem);
    _inHaveInternet.stream.listen((state) =>
        _changeInternetAction(InternetState.connected));
  }

  Future<void> getCoins() async {
    _listItems = await _repository.loadListCoins();
    if (_listItems != null) {
      _outGetCoins.sink.add(_listItems);
      return Future.delayed(Duration(milliseconds: 500))
          .then((_) => colorNotifier.value = Color.fromARGB(255, 175, 246, 250));
    } else {
      return _changeInternetAction(InternetState.notConnected);
    }
  }

  void _changeInternetAction(data) {
    _outInternetStateStream.sink.add(data);
  }

  void _tapOnItem(Coin coin) {
    _outNavigateTo.sink.add(CoinPatternDetailPage(coin: coin));
  }

  void tapOnStartLoading() {
    startLoadingNotifier.value = true;
  }

  void dispose() {
    _outInternetStateStream.close();
    _outNavigateTo.close();
    _outGetCoins.close();
    _inTapOnItem.close();
    _inHaveInternet.close();
  }
}