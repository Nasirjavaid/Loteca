import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/lastRoundResultBloc/lastRoundResultEvent.dart';
import 'package:locteca/bloc/lastRoundResultBloc/lastRoundResultState.dart';
import 'package:locteca/repository/lastRoundResultRepository.dart';



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
          yield LastRoundResultFailureState(errorMessage: "Something Went Wrong");
        }
      } catch (_) {
        yield LastRoundResultFailureState(errorMessage: "Something Went Wrong");
      }
    }

  

    // bool _hasReachedMax(SalarySlipState state) =>
    //     state is SalarySlipSuccessState && state.hasReachedMax;
  }
}
