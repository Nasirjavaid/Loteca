import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/sendCoinBloc/sendCoinEvent.dart';
import 'package:locteca/bloc/sendCoinBloc/sendCoinState.dart';
import 'package:locteca/repository/sendCoinRepository.dart';
import 'package:easy_localization/easy_localization.dart';
class SendCoinBloc extends Bloc<SendCoinEvent, SendCoinState> {
  SendCoinRepository sendCoinRepository = SendCoinRepository();

  SendCoinBloc();

  @override
  SendCoinState get initialState => SendCoinStateInitialState();

  @override
  Stream<SendCoinState> mapEventToState(SendCoinEvent event) async* {
    //final currentState = state;

    if (event is ShowUserValidationFormSendCoinEvent) {
      yield SendCoinStateInProgressState();
      yield ShowSendCoinFormWidgetState();
    }

    if (event is ValidateUserEvent) {
      try {
        yield SendCoinStateInProgressState();
        final sendCoinValidateUser =
            await sendCoinRepository.valiodateUser(event.email);

        if (sendCoinValidateUser.response == "true") {
          yield UserValidatedSuccessfullyState(
              validateUser: sendCoinValidateUser);
        } else if ((sendCoinValidateUser.response == "false")) {
          yield SendCoinStateFailureState(
              errorMessage: sendCoinValidateUser.message);
        } else {
          yield SendCoinStateFailureState(errorMessage: "Something Went Wrong".tr().toString());
        }
      } catch (_) {
        yield SendCoinStateFailureState(errorMessage: "Something Went Wrong".tr().toString());
      }
    }

    if (event is SendCoinsToUserEvent) {
      yield SendCoinStateInProgressState();
      final sendCoinValidateUser =
          await sendCoinRepository.sendCoin(event.email, event.coins);

      if (sendCoinValidateUser.response == "true") {
        yield CoinSentSuccessfullyState(sendCoin: sendCoinValidateUser);

        //yield SendCoinCloseAndRefreshMainAdminDashboard();
      } else if (sendCoinValidateUser.response == "false") {
        yield SendCoinStateFailureState(
            errorMessage: sendCoinValidateUser.message);
      } else {
        yield SendCoinStateFailureState(errorMessage: "Something went wrong".tr().toString());
      }
    }

    if (event is ShowUserValidationFormForBetEvent) {
      yield ShowUserValidationWithEmailFormWidgetState();
    }

    if (event is ValidateUserForBetEvent) {
      yield SendCoinStateInProgressState();
      final validateUser = await sendCoinRepository.valiodateUser(event.email);

      if (validateUser.status == 200) {
        yield UserValidatedSuccessfullyState(validateUser: validateUser);
      }
      if (validateUser.status == 209) {
        yield ShowBoxWhenUserCannotBeVerifiedOrOtherIssueState(
            errorMessage: validateUser.message);
      }
      if (validateUser.status == 404) {
        yield ShowBoxWhenUserCannotBeVerifiedOrOtherIssueState(
            errorMessage: validateUser.message);
      }
    }
  }

  // bool _hasReachedMax(SalarySlipState state) =>
  //     state is SalarySlipSuccessState && state.hasReachedMax;

}
