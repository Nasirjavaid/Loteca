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
    } else {
      throw Exception("Main Round Service: Failed to get Main Round");
    }

    return mainRound;
  }

  Future<MainRound> subMitBetOfMainRound(int roundId,String dataListAsString) async {


    MainRound mainRound;

    UserAuthRepository userAuthRepository = UserAuthRepository();

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

   

   Map<String, dynamic> requestBody = <String, dynamic>{
      'round_id': roundId,
      'selected_answers': dataListAsString,
    };
    final http.Response response = await httpService.postRequestWithToken(
        endPoint: APIConstants.submitMainRoundEndPoint, header: _getRequestHeaders(),data: requestBody);
    print("status code ${response.statusCode}");

    if (response.statusCode == 201) {
      print("response body  in Submit main round service : : ${response.body}");

      var json = jsonDecode(response.body);

     // mainRound = MainRound.fromJson(json);

      print("response body  in Submit Main round service : ${mainRound.message}");
    } else {
      throw Exception("Submit Main Round Service: Failed to get Main Round");
    }

    return mainRound;
  }
}
