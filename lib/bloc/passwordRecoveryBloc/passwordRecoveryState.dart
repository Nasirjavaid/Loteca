import 'package:locteca/model/passwordRecovery.dart';
import 'package:locteca/model/sendCoin.dart';
import 'package:locteca/model/validateUser.dart';

abstract class PasswordRecoveryState {
  const PasswordRecoveryState();

  // @override
  // List<Object> get props => [];
}

class PasswordRecoveryInProgressState extends PasswordRecoveryState {}

class PasswordRecoveryFailedState extends PasswordRecoveryState {
  final PasswordRecovery passwordRecovery;

  PasswordRecoveryFailedState({this.passwordRecovery});
}

class PasswordRecoveryInitialState extends PasswordRecoveryState {}

class PasswordRecoveryCloseScreenState extends PasswordRecoveryState {}

class ShowPasswordRecoveryFormState extends PasswordRecoveryState {
  final PasswordRecovery passwordRecovery;

  ShowPasswordRecoveryFormState({this.passwordRecovery});
}

class ShowPasswordUpdateFormState extends PasswordRecoveryState {
  final String email;

  ShowPasswordUpdateFormState({this.email});
}

class PasswordResetCodeSentSuccessfullyState extends PasswordRecoveryState {
  final PasswordRecovery passwordRecovery;

  PasswordResetCodeSentSuccessfullyState({this.passwordRecovery});
}

class PasswordUpdatedSuccessfullyState extends PasswordRecoveryState {
  final PasswordRecovery passwordRecovery;

  PasswordUpdatedSuccessfullyState({this.passwordRecovery});
}


