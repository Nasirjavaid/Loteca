import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:locteca/bloc/coinRecordBloc/coinRecordEvent.dart';
import 'package:locteca/bloc/coinRecordBloc/coinRecordState.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:locteca/model/coinRecord.dart';
import 'package:locteca/repository/coinRecordRepository.dart';
import 'package:locteca/repository/mainRoundRepository.dart';
import 'package:locteca/repository/sendCoinRepository.dart';

CoinRecord coinRecordGlobal;

class CoinRecordBloc extends Bloc<CoinRecordEvent, CoinRecordState> {
  CoinRecordRepository coinRecordRepository = CoinRecordRepository();
  SendCoinRepository sendCoinRepository = SendCoinRepository();
  MainRoundRepository mainRoundRepository = MainRoundRepository();

  CoinRecordBloc();

  @override
  CoinRecordState get initialState => CoinRecordInitialState();

  @override
  Stream<CoinRecordState> mapEventToState(CoinRecordEvent event) async* {
    //final currentState = state;

    if (event is GetCoinRecordEvent) {
      try {
        yield CoinRecordInProgressState();

        coinRecordGlobal = await coinRecordRepository.getCoinRecord();

        if (coinRecordGlobal.response == "true") {
          yield CoinRecordSuccessState(coinRecord: coinRecordGlobal);
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
    //

    if (event is GetRecordReciptDetailsEvent) {
      try {
        yield UserCoinRecordReciptInProgressState();

        if (event.apiDirectionalCall == 1) {
          final userCoinRecordRecipt =
              await sendCoinRepository.sendCoinRecipt(event.id);

          if (userCoinRecordRecipt.response == "true") {
            yield UserCoinRecordReciptSuccessState(
                sendCoin: userCoinRecordRecipt);
          }}

          if (event.apiDirectionalCall == 2) {
            final mainRound =
                await mainRoundRepository.getUserBetReciptRcord(event.id);

            if (mainRound.response == "true") {
              yield UserBetRecordReciptSuccessState(mainRound: mainRound);
            }
          }

          //yield CoinRecordSuccessState(coinRecord: coinRecordGlobal);
        
      } catch (_) {
        yield CoinRecordFailureState(
            errorMessage: "Something Went Wrong".tr().toString());
      }
    }
  }
}
