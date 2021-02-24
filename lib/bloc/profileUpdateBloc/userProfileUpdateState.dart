
import 'package:locteca/model/userLogin.dart';
import 'package:meta/meta.dart';


abstract class UserProfileUpdateState  {
  const UserProfileUpdateState();


}


class UserProfileUpdateInitialState extends UserProfileUpdateState {}

class UserProfileUPdateLoadingINdicatorScreenState extends UserProfileUpdateState {}


class UserProfileLoadedState extends UserProfileUpdateState {

  final UserLogin userLogin;
  UserProfileLoadedState({this.userLogin});
}


class UserProfileUpdateInProgress extends UserProfileUpdateState {}
class UserProfileUpdateInDataFromSharedPrefrencesState extends UserProfileUpdateState {
final UserLogin userLogin;

  UserProfileUpdateInDataFromSharedPrefrencesState({this.userLogin});
}

class UserProfileUpdateSuccessAndGoToOtherScreen extends UserProfileUpdateState {}

class UserProfileUpdateInSuccess extends UserProfileUpdateState {
  final String message;
  UserProfileUpdateInSuccess({this.message});
}

class UserProfileUpdateFailure extends UserProfileUpdateState {
  final String error;

  const UserProfileUpdateFailure({@required this.error});

  @override
  String toString() => 'Profile update Failure{error": $error}';
}
