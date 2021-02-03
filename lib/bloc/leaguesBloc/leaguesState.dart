import 'package:locteca/model/leaguesModel.dart';

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
  final LeaguesModel leaguesModel;

  const LeaguesSuccessState({this.leaguesModel});
}
