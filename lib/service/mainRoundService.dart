import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/http/httpService.dart';
import 'package:locteca/model/mainRound.dart';
import 'package:locteca/model/userLogin.dart';
import 'package:locteca/repository/userAuthRepository.dart';

class MainRoundService {
  UserLogin userLogin;
  HttpService httpService = new HttpService.internal();
  Map<String, String> _getRequestHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${userLogin.data.token}'
    };
  }

  Future<MainRound> getMainRound() async {
    MainRound mainRound;

    UserAuthRepository userAuthRepository = UserAuthRepository();

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

    // String completeUrlForPayCheck = APIConstants.getPayCheckEndpoint +
    //     "FromDate=" +
    //     fromDate +
    //     "&ToDate=" +
    //     toDate;
    final http.Response response = await httpService.getRequestWithAccessToken(
        endPoint: APIConstants.mainRoundEndPoint, header: _getRequestHeaders());
    print("status code ${response.statusCode}");

    if (response.statusCode == 200) {
      print("response body  in main round service : : ${response.body}");

      var json = jsonDecode(response.body);

      mainRound = MainRound.fromJson(json);

      print("response body  in Main round service : ${mainRound.message}");
    } else if (response.statusCode == 404) {
      var json = jsonDecode(response.body);

      mainRound = MainRound.fromJson(json);
    } else {
      throw Exception("Main Round Service: Failed to get Main Round");
    }

    return mainRound;
  }

  Future<MainRound> getMainRoundForAgent(int userId) async {
    MainRound mainRound;

    UserAuthRepository userAuthRepository = UserAuthRepository();

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

    Map<String, dynamic> requestBody = <String, dynamic>{
      'user_id': userId,
    };
    final http.Response response = await httpService.postRequestWithToken(
        endPoint: APIConstants.mainRoundForAgentEndPoint,
        header: _getRequestHeaders(),
        data: requestBody);
    print("status code ${response.statusCode}");

    if (response.statusCode == 200) {
      print("response body  getMainRoundForAgent: : ${response.body}");

      var json = jsonDecode(response.body);

      mainRound = MainRound.fromJson(json);

      print("response body  in getMainRoundForAgent : ${mainRound.message}");
    } else if (response.statusCode == 404) {
      var json = jsonDecode(response.body);

      mainRound = MainRound.fromJson(json);
    } else {
      throw Exception("Main Round Service: Failed to getMainRoundForAgent");
    }

    return mainRound;
  }

  Future<MainRound> subMitBetOfMainRound(
      int roundId,
      String slectedAnswers,
      String slectedGamesId,
      int selectedPackageId,
      String name,
      String email,
      String phone) async {
    MainRound mainRound;

    UserAuthRepository userAuthRepository = UserAuthRepository();

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

    Map<String, dynamic> requestBody = <String, dynamic>{
      'selected_answers': slectedAnswers,
      'round_id': roundId,
      'package_id': selectedPackageId,
      'game_ids': slectedGamesId,
      'name': name,
      'email': email,
      'phone': phone,
    };
    final http.Response response = await httpService.postRequestWithToken(
        endPoint: APIConstants.submitbetEndPoint,
        header: _getRequestHeaders(),
        data: requestBody);
    print(
        "status code ${response.statusCode}  ${APIConstants.submitbetEndPoint},");

    if (response.statusCode == 201) {
      print("response body  in Submit main round service : : ${response.body}");

      var json = jsonDecode(response.body);

      mainRound = MainRound.fromJson(json);

      print(
          "response body  in Submit Main round service : ${mainRound.message}");
    } else if (response.statusCode > 400) {
      var json = jsonDecode(response.body);

      mainRound = MainRound.fromJson(json);
    } else {
      throw Exception("Submit Main Round Service: Failed to get Main Round");
    }

    return mainRound;
  }

  Future<MainRound> subMitBetOfMainRoundByAgent(
      int roundId,
      String slectedAnswers,
      String slectedGamesId,
      int selectedPackageId,
      int userId) async {
    MainRound mainRound;

    UserAuthRepository userAuthRepository = UserAuthRepository();

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

    Map<String, dynamic> requestBody = <String, dynamic>{
      'selected_answers': slectedAnswers,
      'round_id': roundId,
      'package_id': selectedPackageId,
      'game_ids': slectedGamesId,
      'user_id': userId,
    };
    final http.Response response = await httpService.postRequestWithToken(
        endPoint: APIConstants.submitMainRoundByAgentEndPoint,
        header: _getRequestHeaders(),
        data: requestBody);
    print("status code ${response.statusCode}");

    if (response.statusCode == 201) {
      print("response body  in Submit main round service : : ${response.body}");

      var json = jsonDecode(response.body);

      mainRound = MainRound.fromJson(json);

      print(
          "response body  in Submit Main round service : ${mainRound.message}");
    } else if (response.statusCode > 400) {
      var json = jsonDecode(response.body);

      mainRound = MainRound.fromJson(json);
    } else {
      throw Exception("Submit Main Round Service: Failed to get Main Round");
    }

    return mainRound;
  }

  Future<MainRound> getUserBetReciptRcord(
    int id,
  ) async {
    MainRound mainRound;

    UserAuthRepository userAuthRepository = UserAuthRepository();

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

    Map<String, dynamic> requestBody = <String, dynamic>{
      'record_id': id,
    };
    final http.Response response = await httpService.postRequestWithToken(
        endPoint: APIConstants.betTicketDetailEndPoint,
        header: _getRequestHeaders(),
        data: requestBody);
    print("status code ${response.statusCode}");

    if (response.statusCode == 200) {
      print("response body getUserBetReciptRcord main round service : : ${response.body}");

      var json = jsonDecode(response.body);

      mainRound = MainRound.fromJson(json);

      print(
          "response body  getUserBetReciptRcord Main round service : ${mainRound.message}");
    } else if (response.statusCode >= 400) {
      var json = jsonDecode(response.body);

      mainRound = MainRound.fromJson(json);
    } else {
      throw Exception("getUserBetReciptRcord Main Round Service: Failed to getUserBetReciptRcord");
    }

    return mainRound;
  }
}
