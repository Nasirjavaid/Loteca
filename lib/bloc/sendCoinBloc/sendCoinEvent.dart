abstract class SendCoinEvent {
  // @override
  // List<Object> get props => [];
}

class ShowUserValidationFormSendCoinEvent extends SendCoinEvent {}

class ValidateUserEvent extends SendCoinEvent {
  final String email;
  ValidateUserEvent({this.email});
}

class SendCoinsToUserEvent extends SendCoinEvent {
  final String email;
  final String coins;
  SendCoinsToUserEvent({this.email, this.coins});
}

class ShowUserValidationFormForBetEvent extends SendCoinEvent {}
class ValidateUserForBetEvent extends SendCoinEvent {
  final String email;
  ValidateUserForBetEvent({this.email});
}

class UserVerifiedForBetEvent extends SendCoinEvent {
  final int userId;
  
  UserVerifiedForBetEvent({this.userId,});
}


