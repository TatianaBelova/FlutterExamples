import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_flutter_note/lesson%204/coins/models/coin.dart';

abstract class CoinEvent extends Equatable {
  const CoinEvent();
}

class PageOpenedEvent extends CoinEvent {
  @override
  List<Object> get props => [];
}

class PageClosedEvent extends CoinEvent {
  final String message;

  const PageClosedEvent({@required this.message}) : assert(message != null);
  @override
  List<Object> get props => [message];
}

class ItemPressedEvent extends CoinEvent {
  final Coin coin;

  const ItemPressedEvent({@required this.coin}) : assert(coin != null);

  @override
  List<Object> get props => [coin];
}

class ShowSnackBarEvent extends CoinEvent {
  final String message;

  const ShowSnackBarEvent({@required this.message}) : assert(message != null);
  @override
  List<Object> get props => [message];
}