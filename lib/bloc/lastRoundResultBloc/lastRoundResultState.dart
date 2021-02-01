import 'package:locteca/model/lastRoundResult.dart';


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
