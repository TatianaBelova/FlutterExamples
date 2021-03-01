import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../getting_coin_list_interactor.dart';
import '../models/coin.dart';
import 'coin_detail_page.dart';
import 'loading_page.dart';

class CoinsPage extends StatefulWidget {
  @override
  _CoinsPageState createState() => _CoinsPageState();
}

class _CoinsPageState extends State<CoinsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder(
        future: _loadListCoins(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _coinsWidget(snapshot.data);
          } else if (snapshot.hasError) {
            print('Error');
          }
          return LoadingPage();
        },
      ),
    );
  }

  Future<List<Coin>> _loadListCoins() async =>
      await GettingCoinListInteractor().execute();

  Widget _coinsWidget(List<Coin> coins) => ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ColoredBox(
            color: index % 2 == 0
                ? Color.fromARGB(255, 175, 246, 250)
                : Colors.transparent,
            child: _singleCoin(coins[index]));
      },
      itemCount: 30,
      shrinkWrap: true);

  Widget _singleCoin(Coin coin) => ListTile(
        contentPadding: EdgeInsets.all(5.0),
        onTap: () => _onListItemTap(coin),
        leading: Text(
          coin.symbol,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
        ),
        title: Text(
          coin.name,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
              color: Colors.blueGrey),
        ),
        subtitle: Text('id: ${coin.id}', textAlign: TextAlign.center),
      );

  void _onListItemTap(Coin coin) async {
    String message = await Navigator.of(context).push(
        CupertinoPageRoute(builder: (context) => CoinDetailPage(coin: coin)));
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 500),
    ));
  }
}
