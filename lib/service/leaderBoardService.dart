import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/http/httpService.dart';
import 'package:locteca/model/leaderBoard.dart';
import 'package:locteca/model/mainRound.dart';
import 'package:locteca/model/userLogin.dart';
import 'package:locteca/repository/userAuthRepository.dart';

class LeaderBoardService{



  UserLogin userLogin;
  HttpService httpService = new HttpService.internal();
  Map<String, String> _getRequestHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${userLogin.data.token}'
    };
  }


  Future<LeaderBoardModel> geleaderboard() async {
    LeaderBoardModel leaderBoardModel;

    UserAuthRepository userAuthRepository = UserAuthRepository();

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

    // String completeUrlForPayCheck = APIConstants.getPayCheckEndpoint +
    //     "FromDate=" +
    //     fromDate +
    //     "&ToDate=" +
    //     toDate;
    final http.Response response = await httpService.getRequestWithAccessToken(
        endPoint: APIConstants.leaderBoardEndPoint, header: _getRequestHeaders());
    print("status code ${response.statusCode}");

    if (response.statusCode == 200) {
      print("response body  in lEADERBOARD service : : ${response.body}");

      var json = jsonDecode(response.body);

      leaderBoardModel = LeaderBoardModel.fromJson(json);

      print("response body  in lEADERBOARD service : ${leaderBoardModel.message}");
    } else {
      throw Exception("lEADERBOARD Service: Failed to get lEADERBOARD");
    }

    return leaderBoardModel;
  }
}