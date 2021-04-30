import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/http/httpService.dart';
import 'package:locteca/model/sendCoin.dart';

import 'package:locteca/model/userLogin.dart';
import 'package:locteca/model/validateUser.dart';
import 'package:locteca/repository/userAuthRepository.dart';

class SendCoinService {
  UserLogin userLogin;

  HttpService httpService = new HttpService.internal();

  Map<String, String> _getRequestHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${userLogin.data.token}'
    };
  }

  Future<ValidateUser> validateUser(String email) async {
    ValidateUser validateUser;

    UserAuthRepository userAuthRepository = UserAuthRepository();

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

    Map<String, dynamic> requestBody = <String, dynamic>{
      'email': email,
    };
    final http.Response response = await httpService.postRequestWithToken(
        endPoint: APIConstants.validateUserToSendCoinEndPoint,
        header: _getRequestHeaders(),
        data: requestBody);
    print("status code ${response.statusCode}");

    if (response.statusCode == 200) {
      print("response body  in ValidateUser : : ${response.body}");

      var json = jsonDecode(response.body);

      validateUser = ValidateUser.fromJson(json);

      print("response body  in ValidateUser : ${validateUser.message}");
    } else if (response.statusCode == 404) {
      var json = jsonDecode(response.body);

      validateUser = ValidateUser.fromJson(json);
    } else if (response.statusCode == 209) {
      var json = jsonDecode(response.body);

      validateUser = ValidateUser.fromJson(json);
    } else {
      throw Exception("ValidateUser Service: Failed to ValidateUser");
    }

    return validateUser;
  }

  Future<SendCoin> sendCoins(String email, String coins) async {
    SendCoin sendCoin;

    UserAuthRepository userAuthRepository = UserAuthRepository();

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

    Map<String, dynamic> requestBody = <String, dynamic>{
      'email': email,
      'coins': coins,
    };
    final http.Response response = await httpService.postRequestWithToken(
        endPoint: APIConstants.sendCoinToUserEndPoint,
        header: _getRequestHeaders(),
        data: requestBody);
    print("status code ${response.statusCode}");

    if (response.statusCode == 200) {
      print("response body  in SendCoin : : ${response.body}");

      var json = jsonDecode(response.body);

      sendCoin = SendCoin.fromJson(json);

      print("response body  in SendCoin : ${sendCoin.message}");
    } else if (response.statusCode == 404) {
      var json = jsonDecode(response.body);

      sendCoin = SendCoin.fromJson(json);
    } else if (response.statusCode == 209) {
      var json = jsonDecode(response.body);

      sendCoin = SendCoin.fromJson(json);
    } else {
      throw Exception("SendCoin Service: Failed to SendCoin");
    }

    return sendCoin;
  }

  Future<SendCoin> sentCoinsRecipt(int recordId) async {
    SendCoin sendCoin;

    UserAuthRepository userAuthRepository = UserAuthRepository();

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

    Map<String, dynamic> requestBody = <String, dynamic>{
      'record_id': recordId,
    };
    final http.Response response = await httpService.postRequestWithToken(
        endPoint: APIConstants.coinSentTicketDetailEndPoint,
        header: _getRequestHeaders(),
        data: requestBody);
    print("status code ${response.statusCode}");

    if (response.statusCode == 200) {
      print("response body  in sentCoinsRecipt : : ${response.body}");

      var json = jsonDecode(response.body);

      sendCoin = SendCoin.fromJson(json);

      print("response body  in sentCoinsRecipt : ${sendCoin.message}");
    } else if (response.statusCode == 404) {
      var json = jsonDecode(response.body);

      sendCoin = SendCoin.fromJson(json);
    } else if (response.statusCode == 209) {
      var json = jsonDecode(response.body);

      sendCoin = SendCoin.fromJson(json);
    } else {
      throw Exception("sentCoinsRecipt : Failed to get sentCoinsRecipt");
    }

    return sendCoin;
  }
}
