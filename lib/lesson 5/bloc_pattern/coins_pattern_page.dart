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
    return ValueListenableBuilder(
        valueListenable: _bloc.startLoadingNotifier,
        builder: (_, value, __) => AnimatedSwitcher(
              duration: Duration(milliseconds: 2000),
              child: value ? _page() : _startLoad(),
              transitionBuilder: (Widget child, Animation<double> animation) =>
                  ScaleTransition(
                scale: animation,
                alignment: Alignment.topCenter,
                child: child,
              ),
            ));
  }

  Widget _page() => SingleChildScrollView(
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

  Widget _startLoad() {
    final tween = SizeTween(begin: Size.zero, end: Size(300, 300));
    return Center(
      child: GestureDetector(
        onTap: _bloc.tapOnStartLoading,
        child: TweenAnimationBuilder(
          child: Center(
              child: Text('Начать загрузку данных?',
                  style: TextStyle(fontSize: 18))),
          duration: Duration(seconds: 5),
          curve: Curves.easeInCirc,
          builder: (_, Size size, Widget child) => SizedBox.fromSize(
            child: child,
            size: size,
          ),
          tween: tween,
        ),
      ),
    );
  }

  Widget _coinsWidget() => StreamBuilder(
      stream: _bloc.streamCoins,
      builder: (context, snapshot) => snapshot.hasData
          ? ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ValueListenableBuilder(
                  valueListenable: _bloc.colorNotifier,
                  child: _singleCoin(snapshot.data[index]),
                  builder: (_, value, Widget child) => AnimatedContainer(
                    duration: Duration(seconds: 2),
                    color: index % 2 == 0 ? value : Colors.transparent,
                    child: child,
                  ),
                );
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
