import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/userProfileBloc/userProfileEvent.dart';
import 'package:locteca/bloc/userProfileBloc/userProfileState.dart';
import 'package:locteca/model/userLogin.dart';
import 'package:locteca/repository/userAuthRepository.dart';


class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  @override
  UserProfileState get initialState => InitialUserProfileState();

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async* {
    if (event is GetUserDataUserProfileEvent) {
      yield InProgresssGettingUserProfileState();
      UserAuthRepository userAuthRepository = UserAuthRepository();
      UserLogin userLogin = UserLogin();
      userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

      if (userLogin != null) {
        yield UserProfiledetailTakenSuccessfully(userLogin: userLogin);
      } else {
        yield FailedTogetUserProfileData(
            error: "User Profile bloc : unable to get user profile data data");
      }
    } else {
      yield FailedTogetUserProfileData(
          error: "User Profile bloc : unable to get user profile data data");
    }
  }
}
