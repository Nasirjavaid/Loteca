import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/http/httpService.dart';

import 'package:locteca/model/leaguesModel.dart';

import 'package:locteca/model/userLogin.dart';
import 'package:locteca/repository/userAuthRepository.dart';

class LeaguesService{



  UserLogin userLogin;
  HttpService httpService = new HttpService.internal();
  Map<String, String> _getRequestHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${userLogin.data.token}'
    };
  }


  Future<LeaguesModel> getLeagues() async {
    LeaguesModel leaguesModel;

    UserAuthRepository userAuthRepository = UserAuthRepository();

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

    // String completeUrlForPayCheck = APIConstants.getPayCheckEndpoint +
    //     "FromDate=" +
    //     fromDate +
    //     "&ToDate=" +
    //     toDate;
    final http.Response response = await httpService.getRequestWithAccessToken(
        endPoint: APIConstants.leaguesEndPoint, header: _getRequestHeaders());
    print("status code ${response.statusCode}");

    if (response.statusCode == 200) {
      print("response body  in Leagues service : : ${response.body}");

      var json = jsonDecode(response.body);

      leaguesModel = LeaguesModel.fromJson(json);

      print("response body  in Leagues service : ${leaguesModel.message}");
    } else {
      throw Exception("Leagues Service: Failed to get Leagues");
    }

    return leaguesModel;
  }
}