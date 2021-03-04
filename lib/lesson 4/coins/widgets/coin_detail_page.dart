import 'package:flutter/material.dart';
import 'package:my_flutter_note/lesson%204/coins/models/coin.dart';
import 'package:my_flutter_note/lesson%204/coins/models/coin_event.dart';

import '../getting_coin_events_interactor.dart';
import 'loading_page.dart';

class CoinDetailPage extends StatelessWidget {
  final Coin coin;

  CoinDetailPage({@required this.coin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(coin.name),
          leading: GestureDetector(
              onTap: () => Navigator.of(context)
                  .pop('Вы только что узнали больше о ${coin.name}'),
              child: Icon(Icons.arrow_back, color: Colors.blueGrey)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                FutureBuilder(
                  future: _loadCoinEvents(),
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.done &&
                            snapshot.data != null
                        ? snapshot.data.length == 0
                            ? Text('Событий не найдено')
                            : _listEvents(snapshot.data)
                        : LoadingPage();
                  },
                )
              ],
            ),
          ),
        ));
  }

  Future<List<CoinEventModel>> _loadCoinEvents() async =>
      await GettingCoinEventsInteractor().execute(coinId: coin.id);

  Widget _listEvents(List<CoinEventModel> events) => ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: events.length,
        itemBuilder: (context, index) => _eventWidget(events[index]),
      );

  Widget _eventWidget(CoinEventModel event) => Builder(
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
