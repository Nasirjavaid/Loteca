import 'package:locteca/model/mainRound.dart';
import 'package:locteca/model/validateUser.dart';

abstract class MainRoundEvent {
  // @override
  // List<Object> get props => [];
}

class GetMainRoundEvent extends MainRoundEvent {

  int mainRoundCallDirection;
  int userId;
  GetMainRoundEvent({this.mainRoundCallDirection,this.userId});
}

class OnBetPriceChangeMainRoundEvent extends MainRoundEvent {
  int coins;
  OnBetPriceChangeMainRoundEvent({this.coins});
}

class SubmitBetButtonClickedEvent extends MainRoundEvent {
  final MainRound mainRound;

  SubmitBetButtonClickedEvent({this.mainRound});
}

class GetActiveOrInvitedLeagueDetailEvent extends MainRoundEvent {
  final int roundId;
  GetActiveOrInvitedLeagueDetailEvent({this.roundId});
}

class SubmitBetButtonClickedFromAgentSideEvent extends MainRoundEvent {
  final MainRound mainRound;
  final ValidateUser validateUser;

  SubmitBetButtonClickedFromAgentSideEvent({this.mainRound,this.validateUser});
}
