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

        final leagues = await leaguesRepository.getLeagues();

        if (leagues.response == "true") {
          yield LeaguesSuccessState(leaguesModel: leagues);
        } else {
          yield LeaguesFailureState(errorMessage: "Something Went Wrong");
        }
      } catch (_) {
        yield LeaguesFailureState(errorMessage: "Something Went Wrong");
      }
    }

    // bool _hasReachedMax(SalarySlipState state) =>
    //     state is SalarySlipSuccessState && state.hasReachedMax;
  }
}
