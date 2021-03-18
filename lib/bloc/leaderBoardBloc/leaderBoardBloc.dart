import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/leaderBoardBloc/leaderBoardEvent.dart';
import 'package:locteca/bloc/leaderBoardBloc/leaderBoardState.dart';
import 'package:locteca/repository/leaderBoardRepository.dart';
import 'package:easy_localization/easy_localization.dart';
class LeaderBoardBloc extends Bloc<LeaderBoardEvent, LeaderBoardState> {
  LeaderBoardRepository leaderBoardRepository = LeaderBoardRepository();

  LeaderBoardBloc();

  @override
  LeaderBoardState get initialState => LeaderBoardInitialState();

  @override
  Stream<LeaderBoardState> mapEventToState(LeaderBoardEvent event) async* {
    //final currentState = state;

    if (event is GetLeaderBoardListEvent) {
      try {
        yield LeaderBoardInProgressState();

        final leaderboard = await leaderBoardRepository.getLeaderBoard();

        if (leaderboard.response == "true") {
          yield LeaderBoardSuccessState(leaderBoardModel: leaderboard);
        } else {
          yield LeaderBoardFailureState(errorMessage: "Something Went Wrong".tr().toString());
        }
      } catch (_) {
        yield LeaderBoardFailureState(errorMessage: "Something Went Wrong");
      }
    }

    // bool _hasReachedMax(SalarySlipState state) =>
    //     state is SalarySlipSuccessState && state.hasReachedMax;
  }
}
