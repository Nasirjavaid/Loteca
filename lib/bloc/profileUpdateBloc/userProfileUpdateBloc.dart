import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/profileUpdateBloc/userProfileUpdateState.dart';
import 'package:locteca/config/methods.dart';
import 'package:locteca/model/userLogin.dart';
import 'package:locteca/repository/profileUpdateRepository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'userProfileUpdateEvent.dart';

class UserProfileUpdateBloc
    extends Bloc<UserProfileUpdateEvent, UserProfileUpdateState>
    with ValidationMixin {
  @override
  UserProfileUpdateState get initialState => UserProfileUpdateInitialState();

  UserProfileUpdateUpRepository userProfileUpdateUpRepository =
      UserProfileUpdateUpRepository();
  UserLogin userLogin;

  @override
  Stream<UserProfileUpdateState> mapEventToState(
      UserProfileUpdateEvent event) async* {
    if (event is UserProfileUpdateGetUserDataFromSharedPrefrences) {
      yield UserProfileUPdateLoadingINdicatorScreenState();
      UserLogin userLogin = await Methods.userInfoStoredInsharedPrefrences();
     // await Future.delayed(Duration(milliseconds: 400));
      yield UserProfileUpdateInDataFromSharedPrefrencesState(
          userLogin: userLogin);
    }

    if (event is UserProfileUpdateButtonPressed) {
      userLogin = UserLogin();
      yield UserProfileUpdateInProgress();
      if (this.isFieldEmpty(event.name)) {
        yield UserProfileUpdateFailure(
            error: "Please Enter Name".tr().toString());
        return;
      } else if (this.isFieldEmpty(event.email)) {
        yield UserProfileUpdateFailure(
            error: "Please Enter Email".tr().toString());
        return;
      } else if (!event.email.contains("@") || !event.email.contains(".")) {
        yield UserProfileUpdateFailure(
            error: "Please Enter Valid Email".tr().toString());
        return;
      }
      //  else if (this.isFieldEmpty(event.password)) {
      //   yield UserProfileUpdateFailure(error: "Please enter password.");
      //   return;
      // }
      // else if (event.password.length <= 4) {
      //   yield UserProfileUpdateFailure(
      //       error: "Password length must be more or equal to  4 characters.");
      //   return;
      // }

      else if (this.isFieldEmpty(event.phone)) {
        yield UserProfileUpdateFailure(
            error: "Please enter Phone number".tr().toString());
        return;
      } else if (this.isFieldEmpty(event.whatsApp)) {
        yield UserProfileUpdateFailure(
            error: "Please enter WhatsApp number".tr().toString());
        return;
      } else {
        String newPhone = "";
        String newWhatsApp = "";
        if (!event.phone.startsWith("+55")) {
          newPhone = "+55" + event.phone;
        } else {
          newPhone = event.phone;
        }

        if (!event.whatsApp.startsWith("+55")) {
          newWhatsApp = "+55" + event.whatsApp;
        } else {
          newWhatsApp = event.whatsApp;
        }

        userLogin = await userProfileUpdateUpRepository.updateUserProfile(
            event.role,
            event.name,
            event.email,
            event.oldPassword,
            event.newPassword,
            newPhone,
            newWhatsApp,
            event.profilePicturePath);

        if (userLogin.status != 200) {
          yield UserProfileUpdateFailure(error: userLogin.message);
        } else if (userLogin.status == 200) {
          yield UserProfileUpdateInProgress();

          Methods.storeUserToSharedPref(userLogin);

          await Future.delayed(Duration(microseconds: 500));
          yield UserProfileUpdateInSuccess(message: userLogin.message);
          await Future.delayed(Duration(microseconds: 500));
          yield UserProfileUpdateSuccessAndGoToOtherScreen();
        }
      }
    }
  }
}
