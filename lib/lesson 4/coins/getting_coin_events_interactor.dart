import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_flutter_note/lesson%204/coins/models/coin_event.dart';

import 'api.dart';

class GettingCoinEventsInteractor {
  Future<List<CoinEventModel>> execute({String coinId}) async {
    try {
      Response response = await getCoinEventsFromApi(coinId);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<CoinEventModel> result = data.map((e) => CoinEventModel.fromJson(e)).toList();
        return result;
      } else {
        print('Error');
      }
    } catch (ex) {
      return null;
    }
    return null;
  }
}