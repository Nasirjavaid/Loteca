import 'package:locteca/model/mainRound.dart';

abstract class MainRoundState {
  const MainRoundState();

  // @override
  // List<Object> get props => [];
}

class MainRoundInProgressState extends MainRoundState {}
class MainRoundUserEmailIsnotVarifiedYetState extends MainRoundState {}


class MainRoundBetSubmitingInProgressState extends MainRoundState {

   final MainRound mainRound;

    MainRoundBetSubmitingInProgressState({this.mainRound});
}

class OnBetPriceChangeState extends MainRoundState {

   final MainRound mainRound;

   OnBetPriceChangeState({this.mainRound});
}



class MainRoundInitialState extends MainRoundState {


}

class MainRoundUpdateWidgetState extends MainRoundState {
final MainRound mainRound;

   MainRoundUpdateWidgetState({this.mainRound});
  
}

class NoLiveRoundAvailableMainRoundState extends MainRoundState {

   final String errorMessage;
  const NoLiveRoundAvailableMainRoundState({this.errorMessage});
}

class MainRoundFailureState extends MainRoundState {
  final String errorMessage;
  const MainRoundFailureState({this.errorMessage});
}

class MainRoundSuccessState extends MainRoundState {
  final MainRound mainRound;

  const MainRoundSuccessState({this.mainRound});
}
