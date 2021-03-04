import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_flutter_note/lesson%204/coins/models/coin.dart';

abstract class CoinState extends Equatable {
  const CoinState();
}

class InitialState extends CoinState {
  @override
  List<Object> get props => [];
}

class ListLoadingState extends CoinState {
  @override
  List<Object> get props => [];
}

class ListLoadedState extends CoinState {
  final List<Coin> listCoins;

  ListLoadedState({@required this.listCoins});
  @override
  List<Object> get props => [listCoins];
}

class ListErrorLoadingState extends CoinState {
  final List<Coin> listCoins;

  ListErrorLoadingState({@required this.listCoins}) : assert(listCoins == null);

  @override
  List<Object> get props => [listCoins];
}

class ShowingSnackBarState extends CoinState {
  final String message;

  ShowingSnackBarState({@required this.message});

  @override
  List<Object> get props => [message];
}

class GoingToNextPageState extends CoinState {
  final Coin coin;

  GoingToNextPageState({@required this.coin});

  @override
  List<Object> get props => [coin];
}

