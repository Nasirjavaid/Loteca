import 'package:locteca/model/userLogin.dart';
import 'package:locteca/service/userAuthService.dart';
import 'package:locteca/service/userLoginService.dart';
import 'package:meta/meta.dart';


class UserAuthRepository {
  UserLoginService userLoginService = UserLoginService();
  UserLogin userLogin = UserLogin();

// Autneticating user by user name and password
  Future<UserLogin> authenticate({
    @required String username,
    @required String password,
  }) async {
    userLogin = await userLoginService.getUser(username, password);
    return userLogin;
  }

//deleteing the token on log out
  Future<void> deleteToken() async {
    // await Future.delayed(Duration(seconds: 1),
    UserLogin userLoginNull = new UserLogin();
   // Methods.storeUserToSharedPref(userLoginNull);

    //);
    return;
  }

//writing user token to shared prefrences
  Future<void> persistToken(UserLogin userLogin) async {
    // await Future.delayed(Duration(seconds: 1));

   // Methods.storeUserToSharedPref(userLogin);
    return;
  }

//check if user already logged in
  Future<bool> hasToken() async {
    try {
     // bool tokenAsGuest = await Methods.getGuestFromSharedPref();
      UserAuthService userAuthService = UserAuthService();
      UserLogin userLoginAuthToken = UserLogin();
      UserLogin tokenFromSharedPref = UserLogin();

     // tokenFromSharedPref = await Methods.getRealUserFromSharedPref();

      // if (tokenAsGuest != null) {
      //   if (tokenAsGuest) {
      //     return true;
      //   } else {
      //     if (tokenFromSharedPref.data != null) {
      //       userLoginAuthToken = await userAuthService
      //           .getUserToken(tokenFromSharedPref.data.customerId);

      //       if (userLoginAuthToken.status == "success") {
      //         Methods.storeUserToSharedPref(userLoginAuthToken);
      //         Methods.storeGuestValueToSharedPref(false);
      //         return true;
      //       } else if (userLoginAuthToken.status == "failed") {
      //         Methods.storeGuestValueToSharedPref(false);
      //         return false;
      //       }
      //     }
      //   }
      // }
      
    } catch (ex) {
      print("Error in user Auth repository  $ex");
    }

    return false;
  }

  // Future<UserLogin> getUserDataFromSharedPrefrences() async {
  //   try {
  //     UserLogin userLogin = await Methods.userInfoStoredInsharedPrefrences();

  //     if (userLogin.data.customerId != null) {
  //       return userLogin;
  //     } else {
  //       return null;
  //     }
  //   } catch (ex) {
  //     print(
  //         "Error in user Auth repository while getting User data from SharedPrefrnces: $ex");
  //   }

  //   return userLogin;
  // }
}
