import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/userAuthBloc/userAuthEvent.dart';
import 'package:locteca/bloc/userAuthBloc/userAuthState.dart';
import 'package:locteca/model/userLogin.dart';
import 'package:locteca/repository/userAuthRepository.dart';

class UserAuthBloc extends Bloc<UserAuthEvent, UserAuthState> {
  @override
  //Starting with initial state of Auththentication
  UserAuthState get initialState => AuthInitial();

  //Refrence to UserAuthRepository
  final UserAuthRepository userAuthRepository;

  //Check for the  UserAuthRepository if null or not /// assert key word used for this purpose
  UserAuthBloc({@required this.userAuthRepository});

  // Mapping Events with state
  @override
  Stream<UserAuthState> mapEventToState(UserAuthEvent event) async* {
    if (state is AuthInitial) {
      await Future.delayed(Duration(seconds: 1));
    }

    //check if Authentication is confirmed from repostory
    if (event is AuthStarted) {
      bool hassToken = await userAuthRepository.hasToken();

      // if token exists then return Login in success
      if (hassToken) {
        //get FCM Token
        // String deviceFCMtoken = await   fcmToken();
        // print("FCM token in Auth Bloc $deviceFCMtoken");

        UserLogin userLoginWithRole = UserLogin();
        userLoginWithRole =
            await userAuthRepository.getUserDataFromSharedPrefrences();

        if (userLoginWithRole.data.user.roles == "1") {
          yield AuthSuccess();
        } else if (userLoginWithRole.data.user.roles == "2") {
          yield AuthSuccessAsAgent();
        } else if (userLoginWithRole.data.user.roles == null ||
            userLoginWithRole.data.user.roles == "") {
          yield AuthFailure();
        } else {
          yield AuthFailure();
        }
      } else {
        // if token doens not exist then return Login in  failure

        yield AuthFailure();
      }
    }

    //Check if user token already exists then move to Dashboard
    if (event is AuthLoggedIn) {
      yield AuthInProgress();
      // await Future.delayed(Duration(milliseconds: 500));

      await userAuthRepository.persistToken(event.userLogin);

      //get FCM Token
      String deviceFCMtoken = await fcmToken();
      print("FCM token in Auth Bloc $deviceFCMtoken");

      if (event.userLogin.data.user.roles == "1") {
        yield AuthSuccess();
      } else if (event.userLogin.data.user.roles == "2") {
        yield AuthSuccessAsAgent();
      } else if (event.userLogin.data.user.roles == null ||
          event.userLogin.data.user.roles == "") {
        yield AuthFailure();
      } else {
        yield AuthFailure();
      }
    }
    //Check if user token does not exist then move to Login Screen
    if (event is AuthLoggedOut) {
      yield AuthInProgress();
      await Future.delayed(Duration(milliseconds: 500));
      await userAuthRepository.deleteToken();

      yield AuthFailure();
    }

    if (event is AuthVerifyEmail) {
      yield AuthInProgress();

      var feedBack = await userAuthRepository.verifyUserCode(event.code);

      if (feedBack.status == 200) {
        yield AuthCodeVerificationMessage(feedback: feedBack);

        await Future.delayed(Duration(milliseconds: 2000));
        yield AuthCodeVerifiedSuccessfully(feedback: feedBack);
        yield AuthSuccess();
      }
      if (feedBack.status == 209) {
        yield AuthCodeVerificationFailed(feedback: feedBack);
        yield AuthSuccess();
      }
      if (feedBack.status >= 400) {
        yield AuthCodeVerificationFailed(feedback: feedBack);
        yield AuthSuccess();
      }
    }

    if (event is AuthReSendCode) {
      yield AuthInProgress();

      var feedBack = await userAuthRepository.resendCode();

      if (feedBack.status == 200) {
        yield AuthCodeResentSuccessfully(feedback: feedBack);
        yield AuthSuccess();
      }
      if (feedBack.status == 209) {
        yield AuthCodeVerificationFailed(feedback: feedBack);
        yield AuthSuccess();
      }
      if (feedBack.status > 400) {
        yield AuthCodeVerificationFailed(feedback: feedBack);
        yield AuthSuccess();
      }
    }
  }

  Future<String> fcmToken() async {
    String deviceFcmToken;
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      deviceFcmToken = token;
      print("Push Messaging token: $token");

      return deviceFcmToken;
    });
    // _firebaseMessaging.subscribeToTopic("matchscore");
    return deviceFcmToken;
  }
}
