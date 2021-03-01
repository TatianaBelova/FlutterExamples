
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<Response> getListCoinsFromApi() async {
  var url = 'https://api.coinpaprika.com/v1/coins';
  return await http.get(url);
}

Future<Response> getCoinEventsFromApi(String coinId) async {
  var url = 'https://api.coinpaprika.com/v1/coins/$coinId/events';
  return await http.get(url);
}

