import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/profileUpdateBloc/userProfileUpdateState.dart';
import 'package:locteca/config/methods.dart';
import 'package:locteca/model/userLogin.dart';
import 'package:locteca/repository/profileUpdateRepository.dart';

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
       await Future.delayed(Duration(seconds: 1));
      yield UserProfileUpdateInDataFromSharedPrefrencesState(
          userLogin: userLogin);
    }

    if (event is UserProfileUpdateButtonPressed) {
      userLogin = UserLogin();
      yield UserProfileUpdateInProgress();
      if (this.isFieldEmpty(event.name)) {
        yield UserProfileUpdateFailure(error: "Please enter name.");
        return;
      } else if (this.isFieldEmpty(event.email)) {
        yield UserProfileUpdateFailure(error: "Please enter email.");
        return;
      } else if (!event.email.contains("@") || !event.email.contains(".")) {
        yield UserProfileUpdateFailure(error: "Please enter valid email.");
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
        yield UserProfileUpdateFailure(error: "Please enter Phone number");
        return;
      } else if (this.isFieldEmpty(event.whatsApp)) {
        yield UserProfileUpdateFailure(error: "Please enter WhatsApp number");
        return;
      } else {
        userLogin = await userProfileUpdateUpRepository.updateUserProfile(
            event.role,
            event.name,
            event.email,
            event.oldPassword,
            event.newPassword,
            event.phone,
            event.whatsApp,
            event.profilePicturePath);

        if (userLogin.message == ("Sorry, Nothing was changed. Please try again later.")) {
          yield UserProfileUpdateFailure(error: userLogin.message);
        } else if (userLogin.status == ("success")) {
          yield UserProfileUpdateInProgress();

          Methods.storeUserToSharedPref(userLogin);

          await Future.delayed(Duration(microseconds: 500));
          yield UserProfileUpdateInSuccess(message: userLogin.message);
          await Future.delayed(Duration(microseconds: 500));
          yield UserProfileUpdateSuccessAndGoToOtherScreen();
        } else if (userLogin.status == ("failed")) {
          yield UserProfileUpdateFailure(error: userLogin.message);
        } else {
          yield UserProfileUpdateFailure(error: "Something went wrong.");
        }
      }
    }
  }
}
