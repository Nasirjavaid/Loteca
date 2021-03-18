import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/mainRoundBloc/mainRoundState.dart';
import 'package:locteca/model/mainRound.dart';
import 'package:locteca/repository/leaguesRepository.dart';
import 'package:locteca/repository/mainRoundRepository.dart';
import 'mainRoundEvent.dart';
import 'package:easy_localization/easy_localization.dart';

class MainRoundBloc extends Bloc<MainRoundEvent, MainRoundState> {
  MainRoundRepository mainRoundRepository = MainRoundRepository();
  LeaguesRepository leaguesRepository = LeaguesRepository();

  MainRound mainRoundGlobal = MainRound();

  MainRoundBloc();

  @override
  MainRoundState get initialState => MainRoundInitialState();

  @override
  Stream<MainRoundState> mapEventToState(MainRoundEvent event) async* {
    //final currentState = state;

    if (event is GetMainRoundEvent) {
      MainRound mainRound = MainRound();
      try {
        yield MainRoundInProgressState();

        if (event.mainRoundCallDirection == 1) {
          mainRound = await mainRoundRepository.getMainRound();
        } else {
          mainRound =
              await mainRoundRepository.getMainRoundForAgent(event.userId);
        }

        if (mainRound.response == "true" && mainRound.status == 200) {
          yield MainRoundSuccessState(mainRound: mainRound);
        } else {
          if (mainRound.status == 404) {
            yield NoLiveRoundAvailableMainRoundState(
                errorMessage: mainRound.message);
          } else {
            yield MainRoundFailureState(errorMessage: "Something Went Wrong".tr().toString());
          }
        }
      } catch (_) {
        yield MainRoundFailureState(errorMessage: "Something Went Wrong".tr().toString());
      }
    }

    if (event is SubmitBetButtonClickedEvent) {
      try {
        MainRound mainRound = MainRound();
        yield MainRoundBetSubmitingInProgressState(mainRound: mainRound);
        // await Future.delayed(Duration(milliseconds: 500));

        mainRound =
            await mainRoundRepository.submitBetOfMainRound(event.mainRound);
        if (mainRound.response == "true") {
          yield MainRoundSuccessState(mainRound: mainRound);
        } else {
          yield MainRoundFailureState(errorMessage: mainRound.message);
        }
      } catch (ex) {
        yield MainRoundFailureState(errorMessage: "Something Went Wrong".tr().toString());
      }
    }

    if (event is SubmitBetButtonClickedFromAgentSideEvent) {
      try {
        MainRound mainRound = MainRound();
        yield MainRoundBetSubmitingInProgressState(mainRound: mainRound);
        // await Future.delayed(Duration(milliseconds: 500));

        mainRound = await mainRoundRepository.submitBetOfMainRoundByAgent(
            event.mainRound, event.validateUser.user.id);
        if (mainRound.response == "true") {
          yield MainRoundSuccessState(mainRound: mainRound);
        } else {
          yield MainRoundFailureState(errorMessage: mainRound.message);
        }
      } catch (ex) {
        yield MainRoundFailureState(errorMessage: "Something Went Wrong".tr().toString());
      }
    }

    // For active leagues and invited Leagues portion

    if (event is GetActiveOrInvitedLeagueDetailEvent) {
      try {
        yield MainRoundInProgressState();

        final mainRound =
            await leaguesRepository.getActiveLeagueDetail(event.roundId);
        mainRoundGlobal = mainRound;

        if (mainRound.response == "true") {
          yield MainRoundSuccessState(mainRound: mainRound);
        } else {
          yield MainRoundFailureState(errorMessage: mainRound.message);
        }
      } catch (_) {
        yield MainRoundFailureState(errorMessage: "Something Went Wrong".tr().toString());
      }
    }

    if (event is OnBetPriceChangeMainRoundEvent) {
      MainRound mainRoundOnBetPriceChange = MainRound();
      mainRoundOnBetPriceChange = mainRoundGlobal;

      int userCoinsUpdatedValue =
          mainRoundOnBetPriceChange.user.coins - event.coins;
      mainRoundOnBetPriceChange.user.coins = userCoinsUpdatedValue;

      yield OnBetPriceChangeState(mainRound: mainRoundOnBetPriceChange);
    }
  }
}
