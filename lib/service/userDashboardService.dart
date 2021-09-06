import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/http/httpService.dart';
import 'package:locteca/model/agentDashboardModel.dart';
import 'package:locteca/model/userDashboard.dart';

import 'package:locteca/model/userLogin.dart';
import 'package:locteca/repository/userAuthRepository.dart';

class UserDashboardService{

  UserLogin userLogin;
  HttpService httpService = new HttpService.internal();
  Map<String, String> _getRequestHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${userLogin.data.token}'
    };
  }


  Future<UserDashboard> getUserDashboardData() async {
    UserDashboard userDashboard;

    UserAuthRepository userAuthRepository = UserAuthRepository();

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

    final http.Response response = await httpService.getRequestWithAccessToken(
        endPoint: APIConstants.userDashboardEndPoint, header: _getRequestHeaders());
    print("status code ${response.statusCode}");

    if (response.statusCode == 200) {
      print("response body  in userDashboard  : : ${response.body}");

      var json = jsonDecode(response.body);

      userDashboard = UserDashboard.fromJson(json);

      print("response body  in userDashboard : ${userDashboard.message}");
    } else {
      throw Exception("userDashboard: Failed to get userDashboard Data");
    }

    return userDashboard;
  }

  
}