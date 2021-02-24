import 'dart:io';

abstract class UserProfileUpdateEvent {
  const UserProfileUpdateEvent();
}

class UserProfileUpdateButtonPressed extends UserProfileUpdateEvent {
  final String role;
  final String name;
  final String email;
  final String oldPassword;
  final String newPassword;
  final String phone;
  final String whatsApp;
  final File profilePicturePath;

  const UserProfileUpdateButtonPressed(this.role, this.name, this.email,
      this.oldPassword,this.newPassword, this.phone, this.whatsApp,this.profilePicturePath);

  @override
  String toString() =>
      'Update ButtonPressed with credentials { username:  password:  }';
}

class UserProfileUpdateGetUserDataFromSharedPrefrences
    extends UserProfileUpdateEvent {}
