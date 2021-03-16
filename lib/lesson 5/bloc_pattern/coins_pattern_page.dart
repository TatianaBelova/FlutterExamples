import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_note/lesson%204/coins/models/coin.dart';
import 'package:my_flutter_note/lesson%204/coins/widgets/loading_page.dart';
import 'package:my_flutter_note/lesson%205/bloc_pattern/coins_pattern_bloc.dart';
import 'package:my_flutter_note/lesson%205/no_internet_page.dart';
import 'package:my_flutter_note/lesson%205/repository.dart';

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
        duration: const Duration(milliseconds: 500),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _bloc.startLoadingNotifier,
      builder: (_, value, __) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 2000),
        child: value ? Page(bloc: _bloc) : StartLoad(bloc: _bloc),
        transitionBuilder: (Widget child, Animation<double> animation) =>
            ScaleTransition(
          scale: animation,
          alignment: Alignment.topCenter,
          child: child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class Page extends StatelessWidget {
  final bloc;

  Page({this.bloc});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: StreamBuilder(
        stream: bloc.internetState,
        initialData: InternetState.connected,
        builder: (context, snapshot) {
          InternetState state = snapshot.data;
          switch (state) {
            case InternetState.connected:
              {
                bloc.getCoins();
                return CoinsWidget(bloc: bloc);
              }
            case InternetState.notConnected:
              {
                return NoInternetPage(
                    haveInternetAction: () => bloc.haveInternet.add(null));
              }
          }
          return Container();
        },
      ),
    );
  }
}

class StartLoad extends StatelessWidget {
  final bloc;
  final tween = SizeTween(begin: Size.zero, end: Size(300, 300));

  StartLoad({this.bloc});

  @override
  Widget build(BuildContext context) => Center(
        child: GestureDetector(
          onTap: bloc.tapOnStartLoading,
          child: TweenAnimationBuilder(
            child: const Center(
                child: const Text('Начать загрузку данных?',
                    style: const TextStyle(fontSize: 18))),
            duration: const Duration(seconds: 5),
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

class CoinsWidget extends StatefulWidget {
  final bloc;

  CoinsWidget({this.bloc});

  @override
  _CoinsWidgetState createState() => _CoinsWidgetState();
}

class _CoinsWidgetState extends State<CoinsWidget> {
  @override
  Widget build(BuildContext context) => StreamBuilder(
      stream: widget.bloc.streamCoins,
      builder: (context, snapshot) => snapshot.hasData
          ? ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ValueListenableBuilder(
                  valueListenable: widget.bloc.colorNotifier,
                  child:
                      SingleCoin(coin: snapshot.data[index], bloc: widget.bloc),
                  builder: (_, value, Widget child) => AnimatedContainer(
                    duration: const Duration(seconds: 2),
                    color: index % 2 == 0 ? value : Colors.transparent,
                    child: child,
                  ),
                );
              },
              shrinkWrap: true,
              itemCount: 30)
          : const LoadingPage());
}

class SingleCoin extends StatelessWidget {
  final Coin coin;
  final bloc;

  SingleCoin({this.coin, this.bloc});

  @override
  Widget build(BuildContext context) => ListTile(
        contentPadding: const EdgeInsets.all(5.0),
        onTap: () => bloc.tapOnItem.add(coin),
        leading: Text(
          coin.symbol,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
        ),
        title: Hero(
          tag: '${coin.name}',
          child: Material(
            color: Colors.transparent,
            child: Text(
              coin.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  color: Colors.blueGrey),
            ),
          ),
        ),
        subtitle: Text('id: ${coin.id}', textAlign: TextAlign.center),
      );
}
