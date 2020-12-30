import 'package:flutter/cupertino.dart';
import 'package:locteca/model/userLogin.dart';


abstract class UserProfileState {}

class InitialUserProfileState extends UserProfileState {}

class InProgresssGettingUserProfileState extends UserProfileState {}

class UserProfiledetailTakenSuccessfully extends UserProfileState {
  final UserLogin userLogin;
  UserProfiledetailTakenSuccessfully({@required this.userLogin});
}

class FailedTogetUserProfileData extends UserProfileState {
  final String error;
  FailedTogetUserProfileData({this.error});
}
