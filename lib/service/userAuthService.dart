import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/http/httpService.dart';
import 'package:locteca/model/feedback.dart';
import 'package:locteca/model/userLogin.dart';
import 'package:locteca/repository/userAuthRepository.dart';

class UserAuthService {
  UserLogin userLogin;

  HttpService httpService = new HttpService.internal();

  Map<String, String> _getRequestHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${userLogin.data.token}'
    };
  }

  Future<Feedback> verifyUserCode(String code) async {
    Feedback feedback;

    UserAuthRepository userAuthRepository = UserAuthRepository();

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

    Map<String, dynamic> requestBody = <String, dynamic>{
      'code': code,
    };
    final http.Response response = await httpService.postRequestWithToken(
        endPoint: APIConstants.confirmEmailEndPoint,
        header: _getRequestHeaders(),
        data: requestBody);
    print("status code ${response.statusCode}");

    if (response.statusCode == 200) {
      print("response body  in email verification : ${response.body}");

      var json = jsonDecode(response.body);

      feedback = Feedback.fromJson(json);

      print("response body  in email verification : ${feedback.message}");
    } else if (response.statusCode == 404) {
      var json = jsonDecode(response.body);

      feedback = Feedback.fromJson(json);
    } else if (response.statusCode == 209) {
      var json = jsonDecode(response.body);

      feedback = Feedback.fromJson(json);
    } else {
      throw Exception(
          "email verification Service: Failed to email verification");
    }

    return feedback;
  }

  Future<Feedback> resendCode() async {
    Feedback feedback;

    UserAuthRepository userAuthRepository = UserAuthRepository();

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

    // Map<String, dynamic> requestBody = <String, dynamic>{
    //   'code': code,
    // };
    final http.Response response = await httpService.getRequestWithAccessToken(
      endPoint: APIConstants.resendCodeEndPoint,
      header: _getRequestHeaders(),
    );
    print("status code ${response.statusCode}");

    if (response.statusCode == 200) {
      print("response body  in resendCode: ${response.body}");

      var json = jsonDecode(response.body);

      feedback = Feedback.fromJson(json);

      print("response body  in resendCode : ${feedback.message}");
    } else if (response.statusCode > 400) {
      var json = jsonDecode(response.body);

      feedback = Feedback.fromJson(json);
    } else if (response.statusCode == 209) {
      var json = jsonDecode(response.body);

      feedback = Feedback.fromJson(json);
    } else {
      throw Exception("resendCode Service: Failed to resendCode");
    }

    return feedback;
  }
}
