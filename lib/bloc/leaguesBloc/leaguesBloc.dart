import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/leaguesBloc/leaguesEvent.dart';
import 'package:locteca/bloc/leaguesBloc/leaguesState.dart';
import 'package:locteca/repository/leaguesRepository.dart';

class LeaguesBloc extends Bloc<LeaguesEvent, LeaguesState> {
  LeaguesRepository leaguesRepository = LeaguesRepository();

  LeaguesBloc();

  @override
  LeaguesState get initialState => LeaguesInitialState();

  @override
  Stream<LeaguesState> mapEventToState(LeaguesEvent event) async* {
    //final currentState = state;

    if (event is GetLeaguesListEvent) {
      try {
        yield LeaguesInProgressState();

        final participatedLeague = await leaguesRepository.getParticipatedLeagues();

        if (participatedLeague.response == "true") {
          yield LeaguesSuccessState(participatedLeague: participatedLeague);
        } else {
          yield LeaguesFailureState(errorMessage: participatedLeague.message);
        }
      } catch (_) {
        yield LeaguesFailureState(errorMessage: "Something Went Wrong");
      }
    }

     if (event is GetClosedLeagueEvent) {
      try {
        yield LeaguesInProgressState();

        final closedLeague = await leaguesRepository.getClosedLeagueDetail(event.roundId);

        if (closedLeague.response == "true") {
          yield ClosedLeaguesSuccessState(closedLeague: closedLeague);
        } else {
          yield LeaguesFailureState(errorMessage: closedLeague.message);
        }
      } catch (_) {
        yield LeaguesFailureState(errorMessage: "Something Went Wrong closedLeague");
      }
    }


    // bool _hasReachedMax(SalarySlipState state) =>
    //     state is SalarySlipSuccessState && state.hasReachedMax;
  }
}
