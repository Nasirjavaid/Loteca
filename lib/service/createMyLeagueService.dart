import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/http/httpService.dart';
import 'package:locteca/model/mainRound.dart';
import 'package:locteca/model/userLogin.dart';
import 'package:locteca/repository/userAuthRepository.dart';

class CreateMyLeagueService {
  
  UserLogin userLogin;

  HttpService httpService = new HttpService.internal();

  Map<String, String> _getRequestHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${userLogin.data.token}'
    };
  }

  Future<MainRound> createMyLeague(String myLeagueName) async {
    MainRound mainRound;

    UserAuthRepository userAuthRepository = UserAuthRepository();

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

    Map<String, dynamic> requestBody = <String, dynamic>{
      'name': myLeagueName,
     
    };
    final http.Response response = await httpService.postRequestWithToken(
        endPoint: APIConstants.createMyLeagueEndPoint,
        header: _getRequestHeaders(),
        data: requestBody);
    print("status code ${response.statusCode}");

    if (response.statusCode == 200) {
      print("response body  in CreateMyLeagueService : : ${response.body}");

      var json = jsonDecode(response.body);

      mainRound = MainRound.fromJson(json);

      print(
          "response body  in CreateMyLeagueService : ${mainRound.message}");
    } else if (response.statusCode == 409) {
      var json = jsonDecode(response.body);

      mainRound = MainRound.fromJson(json);
    } else {
      throw Exception("CreateMyLeagueService: Failed to get CreateMyLeagueService");
    }

    return mainRound;
  }
}
