import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository.dart';
import 'coin_event.dart';
import 'coin_state.dart';

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  CoinBloc() : super(InitialState());

  @override
  Stream<CoinState> mapEventToState(CoinEvent event) async* {
    if (event is PageOpenedEvent) {
      yield* _mapPageOpenedToState();
    }

    if (event is ItemPressedEvent) {
      yield _mapItemPressedToState(event);
    }

    if (event is ShowSnackBarEvent) {
      yield _mapShowSnackBarToState(event);
    }
  }
}

Stream<CoinState> _mapPageOpenedToState() async* {
  yield ListLoadingState();
  try {
    final response = await Repository().loadListCoins();
    if (response != null) {
      yield ListLoadedState(listCoins: response);
    } else {
      yield ListErrorLoadingState(listCoins: null);
    }
  } on dynamic catch(_) {
    rethrow;
  }
}

CoinState _mapItemPressedToState(ItemPressedEvent event) {
  return GoingToNextPageState(coin: event.coin);
}

CoinState _mapShowSnackBarToState(ShowSnackBarEvent event) {
  return ShowingSnackBarState(message: event.message);
}






// Future<CoinState> _mapPageClosedToState(PageClosedEvent event) {
//   return
// }