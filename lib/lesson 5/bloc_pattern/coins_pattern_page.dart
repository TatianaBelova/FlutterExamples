import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_note/lesson%204/coins/models/coin.dart';
import 'package:my_flutter_note/lesson%204/coins/widgets/loading_page.dart';
import 'package:my_flutter_note/lesson%205/bloc_pattern/coins_pattern_bloc.dart';

import '../no_internet_page.dart';
import '../repository.dart';

class CoinsPatternPage extends StatefulWidget {
  @override
  _CoinsPatternPageState createState() => _CoinsPatternPageState();
}

class _CoinsPatternPageState extends State<CoinsPatternPage> {
  final _bloc = CoinsPatternBloc(Repository());

  @override
  void initState() {
    super.initState();
    _bloc.navigateTo.listen((page) async {
      String message = await Navigator.of(context)
          .push(CupertinoPageRoute(builder: (BuildContext context) => page));
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
        duration: Duration(milliseconds: 500),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream: _bloc.internetState,
          initialData: InternetState.connected,
          builder: (context, snapshot) {
            InternetState state = snapshot.data;
            switch (state) {
              case InternetState.connected:
                {
                  _bloc.getCoins();
                  return _coinsWidget();
                }
              case InternetState.notConnected:
                {
                  return NoInternetPage(
                      haveInternetAction: () => _bloc.haveInternet.add(null));
                }
            }
            return Container();
          },
        ));
  }

  Widget _coinsWidget() => StreamBuilder(
      stream: _bloc.streamCoins,
      builder: (context, snapshot) => snapshot.hasData
          ? ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ColoredBox(
                    color: index % 2 == 0
                        ? Color.fromARGB(255, 175, 246, 250)
                        : Colors.transparent,
                    child: _singleCoin(snapshot.data[index]));
              },
              itemCount: 30,
              shrinkWrap: true)
          : LoadingPage());

  Widget _singleCoin(Coin coin) => ListTile(
        contentPadding: EdgeInsets.all(5.0),
        onTap: () => _bloc.tapOnItem.add(coin),
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

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
