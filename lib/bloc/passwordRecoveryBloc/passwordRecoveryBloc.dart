import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/passwordRecoveryBloc/passwordRecoveryEvent.dart';
import 'package:locteca/bloc/passwordRecoveryBloc/passwordRecoveryState.dart';
import 'package:locteca/model/passwordRecovery.dart';
import 'package:locteca/repository/passwordRecoveryRepository.dart';
import 'package:easy_localization/easy_localization.dart';

PasswordRecovery passwordRecovery = PasswordRecovery();
String email;

class PasswordRecoveryBloc
    extends Bloc<PasswordRecoveryEvent, PasswordRecoveryState> {
  PasswordRecoveryRepository passwordRecoveryRepository =
      PasswordRecoveryRepository();

  PasswordRecoveryBloc();

  @override
  PasswordRecoveryState get initialState => PasswordRecoveryInitialState();

  @override
  Stream<PasswordRecoveryState> mapEventToState(
      PasswordRecoveryEvent event) async* {
    if (event is ShowPasswordRecoveryEmailFormEvent) {
      yield ShowPasswordRecoveryFormState();
    }

    if (event is ValidateEmailAddressAndSendPasswordResetCodeEvent) {
      yield PasswordRecoveryInProgressState();
      email = event.email;
      passwordRecovery = await passwordRecoveryRepository
          .validateEmailToSendPasswordResetCode(event.email);

      if (passwordRecovery.status == 200) {
        yield PasswordResetCodeSentSuccessfullyState(
            passwordRecovery: passwordRecovery);
      }
      if (passwordRecovery.status == 209) {
        yield PasswordRecoveryFailedState(passwordRecovery: passwordRecovery);
      }
      if (passwordRecovery.status > 400) {
        yield PasswordRecoveryFailedState(passwordRecovery: passwordRecovery);
      }
    }
    if (event is CodeMatchingEvent) {
      if (event.code == "") {
        passwordRecovery.message = null;
        yield PasswordRecoveryInProgressState();
        await Future.delayed(Duration(milliseconds: 500));
        yield PasswordResetCodeSentSuccessfullyState(
            passwordRecovery: passwordRecovery);
      } else {
        if (passwordRecovery.code == event.code) {
          yield PasswordRecoveryInProgressState();
          await Future.delayed(Duration(milliseconds: 1500));
          yield ShowPasswordUpdateFormState(email: email);
        } else {
          passwordRecovery.message = "You entered the wrong code".tr().toString();
          yield PasswordRecoveryInProgressState();
          await Future.delayed(Duration(milliseconds: 500));
          yield PasswordResetCodeSentSuccessfullyState(
              passwordRecovery: passwordRecovery);
        }
      }
    }

    if (event is UpdatePassowrdEvent) {
      yield PasswordRecoveryInProgressState();
      final passwordRecovery = await passwordRecoveryRepository.updatePassword(
          event.email, event.password);

      if (passwordRecovery.status == 200) {
        yield PasswordUpdatedSuccessfullyState(
            passwordRecovery: passwordRecovery);

        await Future.delayed(Duration(seconds: 2));

        yield PasswordRecoveryCloseScreenState();
      }

      if (passwordRecovery.status == 209) {
        yield PasswordRecoveryFailedState(passwordRecovery: passwordRecovery);
      }
      if (passwordRecovery.status > 400) {
        yield PasswordRecoveryFailedState(passwordRecovery: passwordRecovery);
      }
    }
  }
}
