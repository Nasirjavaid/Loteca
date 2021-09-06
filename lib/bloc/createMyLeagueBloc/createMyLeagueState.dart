
import 'package:locteca/model/mainRound.dart';

abstract class CreateMyLeagueState {
  const CreateMyLeagueState();

  // @override
  // List<Object> get props => [];
}

class CreateMyLeagueProgressState extends CreateMyLeagueState {}

class CreateMyLeagueShowInputFormState extends CreateMyLeagueState {}

class CreateMyLeagueAutoCloseAndReCallMyLeaguesApiState extends CreateMyLeagueState {}
class CreateMyLeagueSubMitBetButtonStateInProgressState extends CreateMyLeagueState {}

class CreateMyLeagueInitialState extends CreateMyLeagueState {}

class CreateMyLeagueFailureState extends CreateMyLeagueState {
  final String errorMessage;
  const CreateMyLeagueFailureState({this.errorMessage});
}

class CreateMyLeagueSuccessState extends CreateMyLeagueState {
  final MainRound mainRound;

  const CreateMyLeagueSuccessState({this.mainRound});
}
