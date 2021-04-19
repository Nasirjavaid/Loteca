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
  //  Dio dio = new Dio();
  UserLogin userLogin;
  HttpService httpService = new HttpService.internal();

  // Map<String, String> _getRequestHeaders() {
  //   return {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer ${userLogin.data.token}'
  //   };
  // }

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

    // Map<String, dynamic> requestBody = <String, dynamic>{
    //   "image": profilePicturePath.path != ""
    //       ? await MultipartFile.fromFile(profilePicturePath.path,
    //           filename: basename(profilePicturePath.path))
    //       : null,
    //   'role': role,
    //   'name': name,
    //   'email': email,
    //   'phone': phone,
    //   'whatsapp': whatsApp,
    // };

    final dio = Dio(BaseOptions(
      connectTimeout: 30000,
      baseUrl: APIConstants.baseUrl,
      responseType: ResponseType.json,
      contentType: ContentType.json.toString(),
    ));

    dio.options.headers["Authorization"] = "Bearer ${userLogin.data.token}";
    FormData formdata = FormData.fromMap({
      "image": profilePicturePath.path != ""
          ? await MultipartFile.fromFile(profilePicturePath.path,
              filename: basename(profilePicturePath.path))
          : null,
      'role': role,
      'name': name,
      'email': email,
      'phone': phone,
      'whatsapp': whatsApp,
    });

    //final http.Response response = await httpService.postRequest(
    //  APIConstants.userProfileUpdateEndpoint, formdata);

    Response response = await dio.post(
      APIConstants.userProfileUpdateEndPoint,
      data: formdata,
      // queryParameters: _getRequestHeaders()
    );

    if (response.statusCode == 200) {
      print("response body  in user Profile update Service: ${response.data}");
      var json = jsonDecode(response.toString());
      if (json['data'] is List) {
        usersLogin.message = json['message'];
        usersLogin.status = json['status'];
      } else {
        usersLogin = UserLogin.fromJson(json);
      }
    } else if (response.statusCode == 400) {
      var json = jsonDecode(response.data);
      print("response body  in Profile update Service: ${response.data}");

      if (json['data'] is List) {
        usersLogin.message = json['data'];
        usersLogin.status = json['status'];
      }

      // usersLogin = UserLogin.fromJson(json);
    } else {
      throw Exception("UserProfileUpdate service: Failed to Register new User");
    }

    return usersLogin;
  }

  //   final http.Response response = await httpService.postRequestWithToken(
  //       endPoint: APIConstants.userProfileUpdateEndPoint,
  //       header: _getRequestHeaders(),
  //       data: requestBody);
  //   print("status code ${response.statusCode}");

  //   if (response.statusCode == 200) {
  //     print("response body  in user Profile update Service: ${response.body}");
  //     var json = jsonDecode(response.toString());

  //     usersLogin = UserLogin.fromJson(json);
  //   } else if (response.statusCode >= 400) {
  //     var json = jsonDecode(response.body);
  //     print("response body  in Profile update Service: ${response.body}");

  //     usersLogin = UserLogin.fromJson(json);
  //   } else {
  //     throw Exception("UserProfileUpdate service: Failed to Register new User");
  //   }

  //   return usersLogin;
  // }
}
