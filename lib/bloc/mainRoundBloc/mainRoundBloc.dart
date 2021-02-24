import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/mainRoundBloc/mainRoundState.dart';
import 'package:locteca/model/mainRound.dart';
import 'package:locteca/repository/leaguesRepository.dart';
import 'package:locteca/repository/mainRoundRepository.dart';
import 'mainRoundEvent.dart';

class MainRoundBloc extends Bloc<MainRoundEvent, MainRoundState> {
  MainRoundRepository mainRoundRepository = MainRoundRepository();
    LeaguesRepository leaguesRepository = LeaguesRepository();

  MainRoundBloc();

  @override
  MainRoundState get initialState => MainRoundInitialState();

  @override
  Stream<MainRoundState> mapEventToState(MainRoundEvent event) async* {
    //final currentState = state;

    if (event is GetMainRoundEvent) {
      try {
        yield MainRoundInProgressState();

        final mainRound = await mainRoundRepository.getMainRound();

        if (mainRound.response == "true") {
          yield MainRoundSuccessState(mainRound: mainRound);
        } else {
          yield MainRoundFailureState(errorMessage: mainRound.message);
        }
      } catch (_) {
        yield MainRoundFailureState(errorMessage: "Something Went Wrong");
      }
    }

    if (event is SubmitBetButtonClickedEvent) {
      try {
        yield MainRoundBetSubmitingInProgressState();
        // await Future.delayed(Duration(milliseconds: 500));
        MainRound mainRound = MainRound();
        mainRound =
            await mainRoundRepository.submitBetOfMainRound(event.mainRound);
        if (mainRound.response == "true") {
//          if(mainRound.bid){

//  yield MainRoundSuccessState(mainRound: mainRound);
//          }
          yield MainRoundSuccessState(mainRound: mainRound);
        } else {
          yield MainRoundFailureState(errorMessage: mainRound.message);
        }
      } catch (ex) {
        yield MainRoundFailureState(errorMessage: "Something Went Wrong");
      }
    }

    // bool _hasReachedMax(SalarySlipState state) =>
    //     state is SalarySlipSuccessState && state.hasReachedMax;

    // For active leagues and invited Leagues portion


       if (event is GetActiveOrInvitedLeagueDetailEvent) {
      try {
        yield MainRoundInProgressState();
      

        final mainRound = await leaguesRepository.getActiveLeagueDetail(event.roundId);

        if (mainRound.response == "true") {
          yield MainRoundSuccessState(mainRound: mainRound);
        } else {
          yield MainRoundFailureState(errorMessage: mainRound.message);
        }
      } catch (_) {
        yield MainRoundFailureState(errorMessage: "Something Went Wrong");
      }
    }
  }
}
