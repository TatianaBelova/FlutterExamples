import 'package:flutter/material.dart';
import 'package:my_flutter_note/lesson%204/coins/models/coin.dart';
import 'package:my_flutter_note/lesson%204/coins/models/coin_event.dart';
import 'package:my_flutter_note/lesson%204/coins/widgets/loading_page.dart';
import 'package:my_flutter_note/lesson%205/bloc_pattern/coin_pattern_detail_bloc.dart';
import 'package:my_flutter_note/lesson%205/repository.dart';

import '../no_internet_page.dart';

class CoinPatternDetailPage extends StatefulWidget {
  final Coin coin;

  CoinPatternDetailPage({@required this.coin});

  @override
  _CoinPatternDetailPageState createState() =>
      _CoinPatternDetailPageState(coin);
}

class _CoinPatternDetailPageState extends State<CoinPatternDetailPage> {
  CoinPatternDetailBloc _bloc;

  _CoinPatternDetailPageState(Coin coin)
      : _bloc = CoinPatternDetailBloc(coin.id, Repository());

  @override
  void initState() {
    super.initState();
    _bloc.navigatorBack.listen((event) => Navigator.of(context)
        .pop('Вы только что узнали больше о ${widget.coin.name}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.coin.name),
          leading: GestureDetector(
              onTap: () => _bloc.tapOnBackButton.add(null),
              child: Icon(Icons.arrow_back, color: Colors.blueGrey)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                StreamBuilder(
                  stream: _bloc.internetState,
                  initialData: InternetState.connected,
                  builder: (context, snapshot) {
                    InternetState state = snapshot.data;
                    switch (state) {
                      case InternetState.connected:
                        {
                          _bloc.getEvents();
                          return _listEvents();
                        }
                      case InternetState.notConnected:
                        {
                          return NoInternetPage(
                              haveInternetAction: () =>
                                  _bloc.haveInternet.add(null));
                        }
                    }
                    return Container();
                  },
                )

                // FutureBuilder(
                //   future: _loadCoinEvents(),
                //   builder: (context, snapshot) {
                //     return snapshot.connectionState == ConnectionState.done &&
                //             snapshot.data != null
                //         ? snapshot.data.length == 0
                //             ? Text('Событий не найдено')
                //             : _listEvents(snapshot.data)
                //         : LoadingPage();
                //   },
                // )
              ],
            ),
          ),
        ));
  }

  Widget _listEvents() => StreamBuilder(
      stream: _bloc.streamEvents,
      builder: (context, snapshot) => snapshot.hasData
          ? snapshot.data.length == 0
              ? Text('Событий не найдено')
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) =>
                      _eventWidget(snapshot.data[index]),
                )
          : LoadingPage());

  Widget _eventWidget(CoinEvent event) => Builder(
        builder: (context) => Container(
          height: 200,
          padding: const EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width - 100,
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(2),
            ),
            elevation: 2,
            child: event.proofImageLink != null
                ? Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      Image.network(
                        event.proofImageLink,
                        fit: BoxFit.fitWidth,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return LoadingPage();
                        },
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _eventDescription(event.description),
                  ),
          ),
        ),
      );

  Widget _eventDescription(String description) => Center(
        child: Text(
            description.isNotEmpty
                ? description
                : 'Описание события отсуствует',
            style: TextStyle(color: Colors.grey, fontSize: 16)),
      );
}
