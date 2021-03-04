import 'dart:async';

import 'package:my_flutter_note/lesson%204/coins/models/coin.dart';
import 'package:my_flutter_note/lesson%205/repository.dart';

import '../no_internet_page.dart';
import 'coin_pattern_detail_page.dart';

class CoinsPatternBloc {
  List<Coin> _listItems;
  Repository _repository;

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
      return _outGetCoins.sink.add(_listItems);
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

  void dispose() {
    _outInternetStateStream.close();
    _outNavigateTo.close();
    _outGetCoins.close();
    _inTapOnItem.close();
    _inHaveInternet.close();
  }
}