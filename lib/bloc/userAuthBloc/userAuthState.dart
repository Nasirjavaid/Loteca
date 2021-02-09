import 'package:equatable/equatable.dart';

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


//initial state 
class NetworkNotAvailableState extends UserAuthState {}