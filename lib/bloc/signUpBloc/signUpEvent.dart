import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignUpButtonPressed extends SignUpEvent {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String address;

  const SignUpButtonPressed(
      this.name, this.email, this.password, this.phone, this.address);

  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'Sign up ButtonPressed with credentials { username:  password:  }';
}
