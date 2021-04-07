import 'package:locteca/model/agentsToBuyCoins.dart';
import 'package:locteca/model/coinRecord.dart';


abstract class CoinRecordState {
  const CoinRecordState();

  // @override
  // List<Object> get props => [];
}

class CoinRecordInProgressState extends CoinRecordState {}

class CoinRecordInitialState extends CoinRecordState {}

class CoinRecordFailureState extends CoinRecordState {
  final String errorMessage;
  const CoinRecordFailureState({this.errorMessage});
}

class CoinRecordSuccessState extends CoinRecordState {
  final CoinRecord coinRecord;

  const CoinRecordSuccessState({this.coinRecord});
}
