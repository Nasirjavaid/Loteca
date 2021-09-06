abstract class PasswordRecoveryEvent {
  // @override
  // List<Object> get props => [];
}

class ShowPasswordRecoveryEmailFormEvent extends PasswordRecoveryEvent {}

class ValidateEmailAddressAndSendPasswordResetCodeEvent extends PasswordRecoveryEvent {
  final String email;
  ValidateEmailAddressAndSendPasswordResetCodeEvent({this.email});
}

class UpdatePassowrdEvent extends PasswordRecoveryEvent {
  final String email;
  final String password;
  UpdatePassowrdEvent({this.email, this.password});
}

class ShowPasswordUpdateFormEvent extends PasswordRecoveryEvent {}


class CodeMatchingEvent extends PasswordRecoveryEvent {
  final String code;
  CodeMatchingEvent({this.code});
}



