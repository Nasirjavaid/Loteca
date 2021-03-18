import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/signUpBloc/signUpEvent.dart';
import 'package:locteca/bloc/signUpBloc/signUpSate.dart';
import 'package:locteca/config/methods.dart';
import 'package:locteca/model/userLogin.dart';
import 'package:locteca/repository/userSignUpRepository.dart';
import 'package:easy_localization/easy_localization.dart';
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
        yield SignUpFailure(error: "Please Enter Name".tr().toString());
        return;
      } else if (this.isFieldEmpty(event.email)) {
        yield SignUpFailure(error: "Please Enter Email".tr().toString());
        return;
      } else if (!event.email.contains("@") || !event.email.contains(".")) {
        yield SignUpFailure(error: "Please Enter Valid Email".tr().toString());
        return;
      } else if (this.isFieldEmpty(event.mobileNumber)) {
        yield SignUpFailure(error: "Please enter Phone number".tr().toString());
        return;
      } else if (this.isFieldEmpty(event.whatsAppNumber)) {
        yield SignUpFailure(error: "Please enter WhatsApp number".tr().toString());
        return;
      } else if (this.isFieldEmpty(event.password)) {
        yield SignUpFailure(error: "Please Enter Password".tr().toString());
        return;
      } else if (event.password.length <= 3) {
        yield SignUpFailure(
            error: "Password length must be more or equal to 4 characters".tr().toString());
        return;
      } else if (event.role == null || event.role == "") {
        yield SignUpFailure(error: "Please select user type.");
        return;
      } else {
        userLogin = await userSignUpRepository.registerNewUser(
          event.name,
          event.email,
          "+55" + event.mobileNumber,
          "+55" + event.whatsAppNumber,
          event.password,
          event.role,
        );

        if (userLogin.response == ("true")) {
          yield SignUpInProgress();
          await Future.delayed(Duration(seconds: 1));
          yield SignUpInSuccess(message: userLogin.message);
          await Future.delayed(Duration(seconds: 1));
          yield SignUpSuccessAndGoToLoginScreen();
        } else if (userLogin.response == ("false")) {
          yield SignUpFailure(error: userLogin.message);
        } else {
          yield SignUpFailure(error: "Something went wrong".tr().toString());
        }
      }
    }
  }
}
