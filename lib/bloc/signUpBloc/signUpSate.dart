import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}


class SignUpInitialState extends SignUpState {}

class SignUpInProgress extends SignUpState {}

class SignUpSuccessAndGoToLoginScreen extends SignUpState {}

class SignUpInSuccess extends SignUpState {
  final String message;
  SignUpInSuccess({this.message});
}


class SignUpFailure extends SignUpState {
  final String error;

  const SignUpFailure({@required this.error});

  @override
  String toString() => 'Sign up Failure{error": $error}';
}
