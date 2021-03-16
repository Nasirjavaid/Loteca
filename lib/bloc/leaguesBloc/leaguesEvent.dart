abstract class LeaguesEvent {
  // @override
  // List<Object> get props => [];
}

class GetLeaguesListEvent extends LeaguesEvent {}

class GetClosedLeagueEvent extends LeaguesEvent {
  final int roundId;
  GetClosedLeagueEvent({this.roundId});
}
