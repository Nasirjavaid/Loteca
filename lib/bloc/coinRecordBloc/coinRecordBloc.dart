import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/agentsBloc/agentsEvent.dart';
import 'package:locteca/bloc/agentsBloc/agentsState.dart';
import 'package:locteca/bloc/coinRecordBloc/coinRecordEvent.dart';
import 'package:locteca/bloc/coinRecordBloc/coinRecordState.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:locteca/repository/coinRecordRepository.dart';

class CoinRecordBloc extends Bloc<CoinRecordEvent, CoinRecordState> {
  CoinRecordRepository coinRecordRepository = CoinRecordRepository();

  CoinRecordBloc();

  @override
  CoinRecordState get initialState => CoinRecordInitialState();

  @override
  Stream<CoinRecordState> mapEventToState(CoinRecordEvent event) async* {
    //final currentState = state;

    if (event is GetCoinRecordEvent) {
      try {
        yield CoinRecordInProgressState();

        final coinRecord = await coinRecordRepository.getCoinRecord();

        if (coinRecord.response == "true") {
          yield CoinRecordSuccessState(coinRecord: coinRecord);
        } else {
          yield CoinRecordFailureState(
              errorMessage: "Something Went Wrong".tr().toString());
        }
      } catch (_) {
        yield CoinRecordFailureState(
            errorMessage: "Something Went Wrong".tr().toString());
      }
    }


    
if (event is GetUserCoinRecordEvent) {
      try {
        yield CoinRecordInProgressState();

        final userCoinRecord = await coinRecordRepository.getUserCoinRecord();

        if (userCoinRecord.response == "true") {
          yield UserCoinRecordSuccessState(userCoinRecord: userCoinRecord);
        } else {
          yield CoinRecordFailureState(
              errorMessage: "Something Went Wrong".tr().toString());
        }
      } catch (_) {
        yield CoinRecordFailureState(
            errorMessage: "Something Went Wrong".tr().toString());
      }
    }
    // bool _hasReachedMax(SalarySlipState state) =>
    //     state is SalarySlipSuccessState && state.hasReachedMax;
  }
}
