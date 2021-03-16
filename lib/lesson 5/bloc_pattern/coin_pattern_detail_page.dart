import 'package:flutter/material.dart';
import 'package:my_flutter_note/lesson%204/coins/models/coin.dart';
import 'package:my_flutter_note/lesson%204/coins/models/coin_event.dart';
import 'package:my_flutter_note/lesson%204/coins/widgets/loading_page.dart';
import 'package:my_flutter_note/lesson%205/bloc_pattern/coin_pattern_detail_bloc.dart';
import 'package:my_flutter_note/lesson%205/no_internet_page.dart';
import 'package:my_flutter_note/lesson%205/repository.dart';

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
          title: Hero(
              tag: '${widget.coin.name}',
              child: Material(
                  color: Colors.transparent,
                  child: Text(widget.coin.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)))),
          leading: GestureDetector(
              onTap: () => _bloc.tapOnBackButton.add(null),
              child: const Icon(Icons.arrow_back, color: Colors.blueGrey)),
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
                          return ListEvents(bloc: _bloc);
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
              ],
            ),
          ),
        ));
  }
}

class ListEvents extends StatelessWidget {
  final bloc;

  ListEvents({this.bloc});

  @override
  Widget build(BuildContext context) => StreamBuilder(
      stream: bloc.streamEvents,
      builder: (context, snapshot) => snapshot.hasData
          ? snapshot.data.length == 0
              ? Text('Событий не найдено')
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) =>
                      EventWidget(event: snapshot.data[index]),
                )
          : const LoadingPage());
}

class EventWidget extends StatelessWidget {
  final CoinEventModel event;

  EventWidget({this.event});

  @override
  Widget build(BuildContext context) => Builder(
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
                          return const LoadingPage();
                        },
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: EventDescription(description: event.description),
                  ),
          ),
        ),
      );
}

class EventDescription extends StatelessWidget {
  final String description;

  EventDescription({this.description});

  @override
  Widget build(BuildContext context) => Center(
        child: Text(
            description.isNotEmpty
                ? description
                : 'Описание события отсуствует',
            style: const TextStyle(color: Colors.grey, fontSize: 16)),
      );
}
