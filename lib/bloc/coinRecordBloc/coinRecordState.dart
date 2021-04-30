
import 'package:locteca/model/coinRecord.dart';
import 'package:locteca/model/mainRound.dart';
import 'package:locteca/model/sendCoin.dart';
import 'package:locteca/model/userCoinRecord.dart';


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

class UserCoinRecordSuccessState extends CoinRecordState {
  final UserCoinRecord userCoinRecord;

  const UserCoinRecordSuccessState({this.userCoinRecord});
}





class UserCoinRecordReciptSuccessState extends CoinRecordState {
  final SendCoin sendCoin;

  const UserCoinRecordReciptSuccessState({this.sendCoin});
}
class UserCoinRecordReciptInProgressState extends CoinRecordState {
  

  const UserCoinRecordReciptInProgressState();
}

class UserBetRecordReciptSuccessState extends CoinRecordState {

  final MainRound mainRound;

  const UserBetRecordReciptSuccessState({this.mainRound});
}
class UserBetRecordReciptInProgressState extends CoinRecordState {
  

  const UserBetRecordReciptInProgressState();
}
