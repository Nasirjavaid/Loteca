import 'package:locteca/model/closedLeague.dart';

import 'package:locteca/model/participatedLeagues.dart';

abstract class LeaguesState {
  const LeaguesState();

  // @override
  // List<Object> get props => [];
}

class LeaguesInProgressState extends LeaguesState {}

class LeaguesInitialState extends LeaguesState {}

class LeaguesFailureState extends LeaguesState {
  final String errorMessage;
  const LeaguesFailureState({this.errorMessage});
}

class LeaguesSuccessState extends LeaguesState {
  final ParticipatedLeague participatedLeague;

  const LeaguesSuccessState({this.participatedLeague});
}

class ClosedLeaguesSuccessState extends LeaguesState {
  final ClosedLeague closedLeague;

  const ClosedLeaguesSuccessState({this.closedLeague});
}
