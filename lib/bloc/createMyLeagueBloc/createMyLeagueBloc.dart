import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/createMyLeagueBloc/createMyLeagueEvent.dart';
import 'package:locteca/bloc/createMyLeagueBloc/createMyLeagueState.dart';
import 'package:locteca/bloc/leaguesBloc/leaguesBloc.dart';
import 'package:locteca/bloc/leaguesBloc/leaguesEvent.dart';
import 'package:locteca/repository/createMyLeagueRepository.dart';

class CreateMyLeagueBloc
    extends Bloc<CreateMyLeagueEvent, CreateMyLeagueState> {
  CreateMyLeagueRepository createMyLeagueRepository =
      CreateMyLeagueRepository();

  //  LeaguesBloc leaguesBloc = LeaguesBloc();

  CreateMyLeagueBloc();



  @override
  CreateMyLeagueState get initialState => CreateMyLeagueInitialState();

  @override
  Stream<CreateMyLeagueState> mapEventToState(
      CreateMyLeagueEvent event) async* {
    //final currentState = state;
   LeaguesBloc leaguesBloc = LeaguesBloc();
    if (event is CreateNewMyLeagueEvent) {
      try {
        yield CreateMyLeagueProgressState();

        final mainRound =
            await createMyLeagueRepository.createMyLeague(event.myLeageName);

        if (mainRound.response == "true") {
          yield CreateMyLeagueSuccessState(mainRound: mainRound);
          
   
//custom delay
          await Future.delayed(Duration(milliseconds: 1500));
          yield CreateMyLeagueAutoCloseAndReCallMyLeaguesApiState();
                //leaguesBloc.add(GetLeaguesListEvent());
        } else {
          yield CreateMyLeagueFailureState(
              errorMessage: "Something Went Wrong");
        }
      } catch (_) {
        yield CreateMyLeagueFailureState(errorMessage: "Something Went Wrong");
      }
    }

    if (event is CreateMyLeagueShowInputFormEvent) {
      yield CreateMyLeagueShowInputFormState();
    }

    // bool _hasReachedMax(SalarySlipState state) =>
    //     state is SalarySlipSuccessState && state.hasReachedMax;
  }
}
