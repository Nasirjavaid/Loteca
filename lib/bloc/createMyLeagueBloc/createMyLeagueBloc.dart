import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/createMyLeagueBloc/createMyLeagueEvent.dart';
import 'package:locteca/bloc/createMyLeagueBloc/createMyLeagueState.dart';
import 'package:easy_localization/easy_localization.dart';
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

    if (event is CreateNewMyLeagueEvent) {
      try {
        yield CreateMyLeagueProgressState();

        final mainRound =
            await createMyLeagueRepository.createMyLeague(event.myLeageName);

        if (mainRound.response == "true") {
          yield CreateMyLeagueSuccessState(mainRound: mainRound);
          
   
//custom delay
          await Future.delayed(Duration(milliseconds: 800));
          yield CreateMyLeagueAutoCloseAndReCallMyLeaguesApiState();
                
        } else {
          yield CreateMyLeagueFailureState(
              errorMessage: "Something Went Wrong".tr().toString());
        }
      } catch (_) {
        yield CreateMyLeagueFailureState(errorMessage: "Something Went Wrong".tr().toString());
      }
    }

    if (event is CreateMyLeagueShowInputFormEvent) {
      yield CreateMyLeagueShowInputFormState();
    }

    // bool _hasReachedMax(SalarySlipState state) =>
    //     state is SalarySlipSuccessState && state.hasReachedMax;
  }
}
