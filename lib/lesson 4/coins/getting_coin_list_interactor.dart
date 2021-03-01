import 'dart:convert';

import 'package:http/http.dart';

import 'api.dart';
import 'models/coin.dart';

class GettingCoinListInteractor {
  Future<List<Coin>> execute({String query}) async {
    try {
      Response response = await getListCoinsFromApi();
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        List<Coin> result = data.map((e) => Coin.fromJson(e)).toList();
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