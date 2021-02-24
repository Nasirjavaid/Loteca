import 'dart:io';

import 'package:locteca/model/userLogin.dart';
import 'package:locteca/service/userProfileUpdateService.dart';



class UserProfileUpdateUpRepository {
  UserProfileUpdateService userProfileUpdateService =
      UserProfileUpdateService();
  Future<UserLogin> updateUserProfile(
      String role,
      String name,
      String email,
      String oldPassword,
      String newPassword,
      String phone,
      String whatsApp,
      File profilePicturePath) async {
    UserLogin userLogin = await userProfileUpdateService.updateUserProfile(
        role, name, email, oldPassword,newPassword, phone, whatsApp, profilePicturePath);

    return userLogin;
  }
}
