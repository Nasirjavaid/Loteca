import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/lastRoundResultBloc/lastRoundResultEvent.dart';
import 'package:locteca/bloc/lastRoundResultBloc/lastRoundResultState.dart';
import 'package:locteca/repository/lastRoundResultRepository.dart';
import 'package:easy_localization/easy_localization.dart';


class LastRoundResulBloc extends Bloc<LastRoundResultEvent, LastRoundResultState> {
  LastRoundResultRepository lastRoundResultRepository = LastRoundResultRepository();

  LastRoundResulBloc();

  @override
  LastRoundResultState get initialState => LastRoundResultInitialState();

  @override
  Stream<LastRoundResultState> mapEventToState(LastRoundResultEvent event) async* {
    //final currentState = state;

    if (event is GetLastRoundResultEvent) {
      try {
        yield LastRoundResultInProgressState();

        final lastRoundResult = await lastRoundResultRepository.getLastRoundResult();

        if (lastRoundResult.response == "true") {
          yield LastRoundResultSuccessState(lastRoundResult: lastRoundResult);
        } else {
          yield LastRoundResultFailureState(errorMessage: "Something Went Wrong".tr().toString());
        }
      } catch (_) {
        yield LastRoundResultFailureState(errorMessage: "Something Went Wrong".tr().toString());
      }
    }

  

    // bool _hasReachedMax(SalarySlipState state) =>
    //     state is SalarySlipSuccessState && state.hasReachedMax;
  }
}
