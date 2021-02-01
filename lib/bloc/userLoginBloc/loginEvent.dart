
import 'package:meta/meta.dart';

abstract class LoginEvent  {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String userName;
  final String password;

  const LoginButtonPressed({@required this.userName, @required this.password});

  // @override
  // List<Object> get props => [userName, password];

  @override
  String toString() => 'LoginButtonPressed with credentials { username: $userName, password: $password }';
}

// class LoginFormEventSubmit extends LoginEvent {
//   final String userName;
//   final String password;
//   LoginFormEventSubmit(this.userName,this.password);

//   @override
//   // TODO: implement props
//   List<Object> get props => [userName,password];

//    @override
//   String toString() => 'FormScreenEventSubmit { username: $userName, password: $password }';
// }
