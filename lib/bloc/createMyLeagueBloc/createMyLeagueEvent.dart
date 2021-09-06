abstract class CreateMyLeagueEvent {
  // @override
  // List<Object> get props => [];
}

class CreateNewMyLeagueEvent extends CreateMyLeagueEvent {
  final String myLeageName;
  CreateNewMyLeagueEvent({this.myLeageName});
}

class CreateMyLeagueShowInputFormEvent extends CreateMyLeagueEvent {}
