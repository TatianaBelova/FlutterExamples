import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_note/lesson%204/coins/getting_coin_list_interactor.dart';
import 'package:my_flutter_note/lesson%204/coins/models/coin.dart';
import 'package:my_flutter_note/lesson%204/coins/widgets/loading_page.dart';
import 'package:my_flutter_note/lesson%205/bloc_library/bloc/coin_bloc.dart';
import 'package:my_flutter_note/lesson%205/bloc_library/bloc/coin_event.dart';
import 'package:my_flutter_note/lesson%205/bloc_library/bloc/coin_state.dart';
import 'package:my_flutter_note/lesson%205/bloc_library/presentation/coin_bloc_library_detail_page.dart';
import 'package:my_flutter_note/lesson%205/no_internet_page.dart';


class CoinsBlocLibraryPage extends StatefulWidget {
  @override
  _CoinsBlocLibraryPageState createState() => _CoinsBlocLibraryPageState();
}

class _CoinsBlocLibraryPageState extends State<CoinsBlocLibraryPage> {

  @override
  void initState() {
    super.initState();
    context.read<CoinBloc>().add(PageOpenedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<CoinBloc, CoinState>(
        builder: (context, CoinState state) {
          if (state is ListLoadingState) {
            return const LoadingPage();
          }
          if (state is ListLoadedState) {
            return _coinsWidget(state.listCoins);
          }
          if (state is ListErrorLoadingState) {
            return NoInternetPage(haveInternetAction: () => context.read<CoinBloc>().add(PageOpenedEvent()));
          }
          if (state is ShowingSnackBarState) {
            Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                  duration: const Duration(milliseconds: 500),
                ));
          }
          if (state is GoingToNextPageState) {
            Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context) => CoinBlockLibraryDetailPage(coin: state.coin)));
          }
          return Container(color: Colors.blueGrey);
        }
      ),
    );
  }

  Future<List<Coin>> _loadListCoins() async =>
      await GettingCoinListInteractor().execute();

  Widget _coinsWidget(List<Coin> coins) => ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
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
        contentPadding: const EdgeInsets.all(5.0),
        onTap: () => _onListItemTap(coin),
        leading: Text(
          coin.symbol,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
        ),
        title: Text(
          coin.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
              color: Colors.blueGrey),
        ),
        subtitle: Text('id: ${coin.id}', textAlign: TextAlign.center),
      );

  void _onListItemTap(Coin coin) {
    context.read<CoinBloc>().add(ItemPressedEvent(coin: coin));
  }
}
