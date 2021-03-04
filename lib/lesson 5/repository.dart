import 'package:my_flutter_note/lesson%204/coins/getting_coin_events_interactor.dart';
import 'package:my_flutter_note/lesson%204/coins/getting_coin_list_interactor.dart';
import 'package:my_flutter_note/lesson%204/coins/models/coin.dart';
import 'package:my_flutter_note/lesson%204/coins/models/coin_event.dart';

class Repository {
  Future<List<Coin>> loadListCoins() async =>
      await GettingCoinListInteractor().execute();

  Future<List<CoinEventModel>> loadCoinEvents(String id) async =>
      await GettingCoinEventsInteractor().execute(coinId: id);
}