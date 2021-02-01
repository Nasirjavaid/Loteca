import 'package:locteca/model/mainRound.dart';

abstract class MainRoundState {
  const MainRoundState();

  // @override
  // List<Object> get props => [];
}

class MainRoundInProgressState extends MainRoundState {}

class MainRoundBetSubmitingInProgressState extends MainRoundState {}



class MainRoundInitialState extends MainRoundState {}

class MainRoundFailureState extends MainRoundState {
  final String errorMessage;
  const MainRoundFailureState({this.errorMessage});
}

class MainRoundSuccessState extends MainRoundState {
  final MainRound mainRound;

  const MainRoundSuccessState({this.mainRound});
}
