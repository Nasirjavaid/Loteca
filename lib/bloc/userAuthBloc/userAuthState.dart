import 'package:equatable/equatable.dart';
import 'package:locteca/model/feedback.dart';

//This state will be returned to UI to update accordinglly 
abstract class UserAuthState extends Equatable {
  @override
  List<Object> get props => [];
}

//initial state 
class AuthInitial extends UserAuthState {}
//Success state
class AuthSuccess extends UserAuthState {}
class AuthSuccessAsAgent extends UserAuthState {}
//failure state
class AuthFailure extends UserAuthState {}
//in progress state
class AuthInProgress extends UserAuthState{}

class AuthCodeVerificationMessage extends UserAuthState{
    final Feedback feedback;
      AuthCodeVerificationMessage({this.feedback});
}

class AuthCodeVerifiedSuccessfully extends UserAuthState {

  final Feedback feedback;
  AuthCodeVerifiedSuccessfully({this.feedback});
}
class AuthCodeVerificationFailed extends UserAuthState {

  final Feedback feedback;
  AuthCodeVerificationFailed({this.feedback});
}

class AuthCodeResentSuccessfully extends UserAuthState {

  final Feedback feedback;
  AuthCodeResentSuccessfully({this.feedback});
}
//initial state 
class NetworkNotAvailableState extends UserAuthState {}