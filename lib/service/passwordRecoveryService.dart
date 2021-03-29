import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/http/httpService.dart';

import 'package:locteca/model/passwordRecovery.dart';

class PasswordRecoveryService {
  Future<PasswordRecovery> validateEmailToSendPasswordResetCode(
      String email) async {
    PasswordRecovery passwordRecovery;

    HttpService httpService = new HttpService.internal();
    Map<String, dynamic> requestBody = <String, dynamic>{
      'email': email,
    };
    final http.Response response = await httpService.postRequest(
        endPoint: APIConstants.resetPasswordCodeEndPoint, data: requestBody);
    print("status code ${response.statusCode}");

    if (response.statusCode == 200) {
      print("response body  in passwordRecoveryService : : ${response.body}");

      var json = jsonDecode(response.body);

      passwordRecovery = PasswordRecovery.fromJson(json);

      print(
          "response body  in passwordRecoveryService : ${passwordRecovery.message}");
    } else if (response.statusCode > 400) {
      var json = jsonDecode(response.body);

      passwordRecovery = PasswordRecovery.fromJson(json);
    } else if (response.statusCode == 209) {
      var json = jsonDecode(response.body);

      passwordRecovery = PasswordRecovery.fromJson(json);
    } else {
      throw Exception("passwordRecoveryService : Failed to password Recovery");
    }

    return passwordRecovery;
  }

  Future<PasswordRecovery> updatePassword(String email, String password) async {
    PasswordRecovery passwordRecovery;

    HttpService httpService = new HttpService.internal();
    Map<String, dynamic> requestBody = <String, dynamic>{
      'email': email,
      'password': email,
    };
    final http.Response response = await httpService.postRequest(
        endPoint: APIConstants.updatePasswordCodeEndPoint, data: requestBody);
    print("status code ${response.statusCode}");

    if (response.statusCode == 200) {
      print("response body  in passwordRecoveryService : : ${response.body}");

      var json = jsonDecode(response.body);

      passwordRecovery = PasswordRecovery.fromJson(json);

      print(
          "response body  in passwordRecoveryService : ${passwordRecovery.message}");
    } else if (response.statusCode > 400) {
      var json = jsonDecode(response.body);

      passwordRecovery = PasswordRecovery.fromJson(json);
    } else if (response.statusCode == 209) {
      var json = jsonDecode(response.body);

      passwordRecovery = PasswordRecovery.fromJson(json);
    } else {
      throw Exception("passwordRecoveryService : Failed to password Recovery");
    }

    return passwordRecovery;
  }
}
