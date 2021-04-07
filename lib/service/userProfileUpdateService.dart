import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/http/httpService.dart';
import 'package:locteca/model/userLogin.dart';
import 'package:locteca/repository/userAuthRepository.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class UserProfileUpdateService {
  UserLogin userLogin;
  HttpService httpService = new HttpService.internal();

  Map<String, String> _getRequestHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${userLogin.data.token}'
    };
  }

  Future<UserLogin> updateUserProfile(
      String role,
      String name,
      String email,
      String oldPassword,
      String newPassword,
      String phone,
      String whatsApp,
      File profilePicturePath) async {
    UserLogin usersLogin = new UserLogin();
   UserAuthRepository userAuthRepository = UserAuthRepository();

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

    // HttpService httpService = new HttpService.internal();

    // Map<dynamic, String> requestBody = <dynamic, String>{
    //   'Customerid': userId,
    //   'customer_name': name,
    //   'UserPicture':await http.MultipartFile.fromPath("field", profilePicturePath.path),
    //   'email': email,
    //   'mobile': phone,
    //   'Address': address,
    //   //'password': password,
    // };
    // FormData formdata = FormData.fromMap({
    //   "image": profilePicturePath.path != ""
    //       ? await MultipartFile.fromFile(profilePicturePath.path,
    //           filename: basename(profilePicturePath.path))
    //       : null,
    //   'role': role,
    //   'customer_name': name,
    //   'email': email,
    //   'phone': phone,
    //   'whatsapp': whatsApp,
    //   // 'password': newPassword == null ? "" : newPassword,
    //   // 'oldpassword': oldPassword == null ? "" : oldPassword,
    // });

    Map<String, dynamic> requestBody = <String, dynamic>{
      "image": profilePicturePath.path != ""
          ? await MultipartFile.fromFile(profilePicturePath.path,
              filename: basename(profilePicturePath.path))
          : null,
      'role': role,
      'customer_name': name,
      'email': email,
      'phone': phone,
      'whatsapp': whatsApp,
    };

    // Response response = await dio.post(
    //   APIConstants.userProfileUpdateEndPoint,
    //   data: formdata,
    //   onSendProgress: (int sent, int total) {
    //     // String percentage = (sent / total * 100).toStringAsFixed(2);
    //   },
    // );

    
    final http.Response response = await httpService.postRequestWithToken(
        endPoint: APIConstants.userProfileUpdateEndPoint,
        header: _getRequestHeaders(),
        data: requestBody);
    print("status code ${response.statusCode}");

    if (response.statusCode == 200) {
      print("response body  in user Profile update Service: ${response.body}");
      var json = jsonDecode(response.toString());

      usersLogin = UserLogin.fromJson(json);
    } else if (response.statusCode >= 400) {
      var json = jsonDecode(response.body);
      print("response body  in Profile update Service: ${response.body}");

      usersLogin = UserLogin.fromJson(json);
    } else {
      throw Exception("UserProfileUpdate service: Failed to Register new User");
    }

    return usersLogin;
  }
}
