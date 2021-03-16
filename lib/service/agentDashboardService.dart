import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/http/httpService.dart';
import 'package:locteca/model/agentDashboardModel.dart';

import 'package:locteca/model/userLogin.dart';
import 'package:locteca/repository/userAuthRepository.dart';

class AgentDashboardService{

  UserLogin userLogin;
  HttpService httpService = new HttpService.internal();
  Map<String, String> _getRequestHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${userLogin.data.token}'
    };
  }


  Future<AgentDashboardModel> getAgentDashboardData() async {
    AgentDashboardModel agentDashboardModel;

    UserAuthRepository userAuthRepository = UserAuthRepository();

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

    final http.Response response = await httpService.getRequestWithAccessToken(
        endPoint: APIConstants.agentDashboardEndPoint, header: _getRequestHeaders());
    print("status code ${response.statusCode}");

    if (response.statusCode == 200) {
      print("response body  in AgentDashboardService  : : ${response.body}");

      var json = jsonDecode(response.body);

      agentDashboardModel = AgentDashboardModel.fromJson(json);

      print("response body  in AgentDashboardService : ${agentDashboardModel.message}");
    } else {
      throw Exception("AgentDashboardService: Failed to get AgentDashboard Data");
    }

    return agentDashboardModel;
  }

  
}