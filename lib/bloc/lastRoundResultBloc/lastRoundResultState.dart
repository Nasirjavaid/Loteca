import 'package:locteca/model/lastRoundResult.dart';
import 'package:locteca/model/roundDetail.dart';

import '../../model/userLogin.dart';


abstract class LastRoundResultState {
  const LastRoundResultState();

  // @override
  // List<Object> get props => [];
}

class LastRoundResultInProgressState extends LastRoundResultState {}

class LastRoundResultInitialState extends LastRoundResultState {}

class LastRoundResultFailureState extends LastRoundResultState {
  final String errorMessage;
  const LastRoundResultFailureState({this.errorMessage});
}

class LastRoundResultSuccessState extends LastRoundResultState {
  final LastRoundResult lastRoundResult;

  const LastRoundResultSuccessState({this.lastRoundResult});
}


class RoundDetailSuccessState extends LastRoundResultState {
  final RoundDetail roundDetail;
  final UserLogin userLogin;

  const RoundDetailSuccessState({this.roundDetail,this.userLogin});
}
