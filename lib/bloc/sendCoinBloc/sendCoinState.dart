
import 'package:locteca/model/sendCoin.dart';
import 'package:locteca/model/validateUser.dart';

abstract class SendCoinState {
  const SendCoinState();

  // @override
  // List<Object> get props => [];
}

class SendCoinStateInProgressState extends SendCoinState {}

class ShowSendCoinFormWidgetState extends SendCoinState {}

class SendCoinStateInitialState extends SendCoinState {}


class SendCoinCloseAndRefreshMainAdminDashboard extends SendCoinState {}

class SendCoinStateFailureState extends SendCoinState {
  final String errorMessage;
  const SendCoinStateFailureState({this.errorMessage});
}

class UserValidatedSuccessfullyState extends SendCoinState {
  final ValidateUser validateUser;

  const UserValidatedSuccessfullyState({this.validateUser});
}

class CoinSentSuccessfullyState extends SendCoinState {
  final SendCoin sendCoin;

  const CoinSentSuccessfullyState({this.sendCoin});
}




class GotToMainRoundScreenState extends SendCoinState {}
class ShowUserValidationWithEmailFormWidgetState extends SendCoinState {}
class ShowBoxWhenUserCannotBeVerifiedOrOtherIssueState extends SendCoinState {
final String errorMessage;

  ShowBoxWhenUserCannotBeVerifiedOrOtherIssueState({this.errorMessage});
}

