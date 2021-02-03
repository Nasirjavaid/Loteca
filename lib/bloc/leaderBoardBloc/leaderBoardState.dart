import 'package:locteca/model/leaderBoard.dart';

abstract class LeaderBoardState {
  const LeaderBoardState();

  // @override
  // List<Object> get props => [];
}

class LeaderBoardInProgressState extends LeaderBoardState {}

class LeaderBoardInitialState extends LeaderBoardState {}

class LeaderBoardFailureState extends LeaderBoardState {
  final String errorMessage;
  const LeaderBoardFailureState({this.errorMessage});
}

class LeaderBoardSuccessState extends LeaderBoardState {
  final LeaderBoardModel leaderBoardModel;

  const LeaderBoardSuccessState({this.leaderBoardModel});
}
