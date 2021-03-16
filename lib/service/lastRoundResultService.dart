import 'dart:convert';

import 'package:locteca/config/appConstants.dart';
import 'package:locteca/http/httpService.dart';
import 'package:locteca/model/lastRoundResult.dart';
import 'package:locteca/model/userLogin.dart';
import 'package:locteca/repository/userAuthRepository.dart';
import 'package:http/http.dart' as http;

class LastRoundResultService{

UserLogin userLogin;
  HttpService httpService = new HttpService.internal();
  Map<String, String> _getRequestHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${userLogin.data.token}'
    };
  }

  Future<LastRoundResult> getLastRoundResult() async {
    LastRoundResult lastRoundResult;

    UserAuthRepository userAuthRepository = UserAuthRepository();

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

   
    final http.Response response = await httpService.getRequestWithAccessToken(
        endPoint: APIConstants.lastRoundResultEndPoint, header: _getRequestHeaders());
    print("status code ${response.statusCode}");

    if (response.statusCode == 200) {
      print("response body  in LastRoundResultService : : ${response.body}");

      var json = jsonDecode(response.body);

      lastRoundResult = LastRoundResult.fromJson(json);

   //   print("response body  in Main round service : ${mainRound.message}");
    } else {
      throw Exception("LastRoundResultService: Failed to LastRoundResultService");
    }

    return lastRoundResult;
  }
}