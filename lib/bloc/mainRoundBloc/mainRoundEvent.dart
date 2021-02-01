import 'package:locteca/model/mainRound.dart';

abstract class MainRoundEvent {
  // @override
  // List<Object> get props => [];
}

class GetMainRoundEvent extends MainRoundEvent {}

class SubmitBetButtonClickedEvent extends MainRoundEvent {


  final MainRound mainRound;

  SubmitBetButtonClickedEvent({this.mainRound});
}
