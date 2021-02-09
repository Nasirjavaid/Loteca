import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignUpButtonPressed extends SignUpEvent {
  final String name;
  final String email;
  final String mobileNumber;
  final String whatsAppNumber;
  final String password;
  final String role;
 

  const SignUpButtonPressed(
      this.name, this.email,this.mobileNumber,this.whatsAppNumber, this.password, this.role, );

  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'Sign up ButtonPressed with credentials { username:  password:  }';
}
