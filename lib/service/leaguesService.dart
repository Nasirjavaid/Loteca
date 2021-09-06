import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/http/httpService.dart';
import 'package:locteca/model/closedLeague.dart';

import 'package:locteca/model/leaguesModel.dart';
import 'package:locteca/model/mainRound.dart';
import 'package:locteca/model/participatedLeagues.dart';

import 'package:locteca/model/userLogin.dart';
import 'package:locteca/repository/userAuthRepository.dart';

class LeaguesService {
  UserLogin userLogin;
  HttpService httpService = new HttpService.internal();
  UserAuthRepository userAuthRepository = UserAuthRepository();
  Map<String, String> _getRequestHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${userLogin.data.token}'
    };
  }

  Future<LeaguesModel> getLeagues() async {
    LeaguesModel leaguesModel;

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

  Future<MainRound> getActiveLeagueDetail(int roundId) async {
    MainRound mainRound;

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

    Map<String, dynamic> requestBody = <String, dynamic>{
      'round_id': roundId,
    };
    final http.Response response = await httpService.postRequestWithToken(
        endPoint: APIConstants.getSingleActiverLeagueEndPoint,
        header: _getRequestHeaders(),
        data: requestBody);
    print("status code ${response.statusCode}");

    if (response.statusCode == 200) {
      print("response body  in getActiveLeagueDetail : : ${response.body}");

      var json = jsonDecode(response.body);

      mainRound = MainRound.fromJson(json);

      print("response body  in getActiveLeagueDetail : ${mainRound.message}");
    } else if (response.statusCode == 404) {
      var json = jsonDecode(response.body);

      mainRound = MainRound.fromJson(json);
    } else {
      throw Exception(
          "getActiveLeagueDetail Service: Failed to getActiveLeagueDetail");
    }

    return mainRound;
  }

  Future<ClosedLeague> getClosedLeagueDetail(
      int roundId, String bettingDate) async {
    ClosedLeague closedLeague;

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

    Map<String, dynamic> requestBody = <String, dynamic>{
      'round_id': roundId,
      'betting_date': bettingDate,
    };
    final http.Response response = await httpService.postRequestWithToken(
        endPoint: APIConstants.getParticipatedleagueDetailsEndPoint,
        header: _getRequestHeaders(),
        data: requestBody);
    print("status code ${response.statusCode}");

    if (response.statusCode == 200) {
      print("response body  in getActiveLeagueDetail : : ${response.body}");

      var json = jsonDecode(response.body);

      closedLeague = ClosedLeague.fromJson(json);

      print(
          "response body  in getActiveLeagueDetail : ${closedLeague.message}");
    } else if (response.statusCode == 404) {
      var json = jsonDecode(response.body);

      closedLeague = ClosedLeague.fromJson(json);
    } else {
      throw Exception(
          "getActiveLeagueDetail Service: Failed to getActiveLeagueDetail");
    }

    return closedLeague;
  }

  Future<ParticipatedLeague> getParticipatedLeagues() async {
    ParticipatedLeague participatedLeague;

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

    // String completeUrlForPayCheck = APIConstants.getPayCheckEndpoint +
    //     "FromDate=" +
    //     fromDate +
    //     "&ToDate=" +
    //     toDate;
    final http.Response response = await httpService.getRequestWithAccessToken(
        endPoint: APIConstants.getParticipatedLeaguesEndPoint,
        header: _getRequestHeaders());
    print("status code ${response.statusCode}");

    if (response.statusCode == 200) {
      print(
          "response body  in participatedLeague service : : ${response.body}");

      var json = jsonDecode(response.body);

      participatedLeague = ParticipatedLeague.fromJson(json);

      print(
          "response body  in participatedLeague service : ${participatedLeague.message}");
    } else if (response.statusCode >= 400) {
      var json = jsonDecode(response.body);

      participatedLeague = ParticipatedLeague.fromJson(json);
    } else {
      throw Exception(
          "participatedLeague Service: Failed to get participatedLeague");
    }

    return participatedLeague;
  }
}
