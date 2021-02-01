import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:locteca/bloc/userAuthBloc/userAuthBloc.dart';
import 'package:locteca/bloc/userAuthBloc/userAuthEvent.dart';
import 'package:locteca/bloc/userLoginBloc/loginState.dart';
import 'package:locteca/config/methods.dart';
import 'package:locteca/model/userLogin.dart';
import 'package:locteca/repository/userAuthRepository.dart';
import 'package:locteca/service/userLoginService.dart';

import 'loginEvent.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with ValidationMixin {
  //Repositiry to get User inforation
  final UserAuthRepository userAuthRepository;
  //User Auth block refrence to talk Bloc to Bloc
  final UserAuthBloc userAuthBloc;
  UserLoginService userLoginService = UserLoginService();

  LoginBloc({@required this.userAuthRepository, @required this.userAuthBloc});
  // : assert(userAuthRepository != null),
  //   assert(userAuthBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(event) async* {
    if (event is LoginButtonPressed) {
      yield LoginInProgress();

      if (this.isFieldEmpty(event.userName)) {
        yield LoginFailure(error: "Please enter email address");
        return;
      } else if (!this.validateEmailAddress(event.userName)) {
        yield LoginFailure(error: "Please enter valid email address");
        return;
      } else if (this.isFieldEmpty(event.password)) {
        yield LoginFailure(error: "Please enter password");
        return;
      } else {
        try {
          UserLogin userLogin = UserLogin();
          userLogin = await userAuthRepository.authenticate(
              username: event.userName, password: event.password);

          if (userLogin == null) {
            yield LoginFailure(error: "Wrong email or password.");
          } else if (userLogin != null) {
            userAuthBloc.add(AuthLoggedIn(userLogin: userLogin));
          }

          yield LoginInitial();
        } catch (error) {
          yield LoginFailure(error: "Wrong email or password. $error");
        }
      }
    }
  }
}
