import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/signUpBloc/signUpEvent.dart';
import 'package:locteca/bloc/signUpBloc/signUpSate.dart';
import 'package:locteca/config/methods.dart';
import 'package:locteca/model/userLogin.dart';
import 'package:locteca/repository/userSignUpRepository.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> with ValidationMixin {
  @override
  SignUpState get initialState => SignUpInitialState();

  UserSignUpRepository userSignUpRepository = UserSignUpRepository();
  UserLogin userLogin;

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpButtonPressed) {
      userLogin = UserLogin();
      yield SignUpInProgress();
      if (this.isFieldEmpty(event.name)) {
        yield SignUpFailure(error: "Please enter name.");
        return;
      } else if (this.isFieldEmpty(event.email)) {
        yield SignUpFailure(error: "Please enter email.");
        return;
      } else if (!event.email.contains("@") || !event.email.contains(".")) {
        yield SignUpFailure(error: "Please enter valid email.");
        return;
      } else if (this.isFieldEmpty(event.mobileNumber)) {
        yield SignUpFailure(error: "Please enter mobile number.");
        return;
      } else if (this.isFieldEmpty(event. whatsAppNumber)) {
        yield SignUpFailure(error: "Please enter WhatsApp number");
        return;
      } else if (this.isFieldEmpty(event.password)) {
        yield SignUpFailure(error: "Please enter password.");
        return;
      } else if (event.password.length <= 3) {
        yield SignUpFailure(
            error: "Password length must be more or equal to 4 characters.");
        return;
      } else if (event.role == null || event.role == "") {
        yield SignUpFailure(error: "Please select user type.");
        return;
      } else {
        userLogin = await userSignUpRepository.registerNewUser(
          event.name,
          event.email,
          event.mobileNumber,
          event.whatsAppNumber,
          event.password,
          event.role,
        );

        if (userLogin.response == ("true")) {
          yield SignUpInProgress();
          await Future.delayed(Duration(seconds: 1));
          yield SignUpInSuccess(message: userLogin.message);
          await Future.delayed(Duration(seconds: 2));
          yield SignUpSuccessAndGoToLoginScreen();
        } else if (userLogin.response == ("false")) {
          yield SignUpFailure(error: userLogin.message);
        } else {
          yield SignUpFailure(error: "Something went wrong.");
        }
      }
    }
  }
}
