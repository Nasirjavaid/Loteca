import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/http/httpService.dart';
import 'package:locteca/model/agentsToBuyCoins.dart';
import 'package:locteca/model/userLogin.dart';
import 'package:locteca/repository/userAuthRepository.dart';

class AgentsService{

  UserLogin userLogin;
  HttpService httpService = new HttpService.internal();
  Map<String, String> _getRequestHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${userLogin.data.token}'
    };
  }


  Future<AgentsToBuyCoins> getAgents() async {
    AgentsToBuyCoins agentsToBuyCoins;

    UserAuthRepository userAuthRepository = UserAuthRepository();

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

    // String completeUrlForPayCheck = APIConstants.getPayCheckEndpoint +
    //     "FromDate=" +
    //     fromDate +
    //     "&ToDate=" +
    //     toDate;
    final http.Response response = await httpService.getRequestWithAccessToken(
        endPoint: APIConstants.agentsEndPoint, header: _getRequestHeaders());
    print("status code ${response.statusCode}");

    if (response. statusCode == 200) {
      print("response body  in agentsToBuyCoins service : : ${response.body}");

      var json = jsonDecode(response.body);

      agentsToBuyCoins = AgentsToBuyCoins.fromJson(json);

      print("response body  in agentsToBuyCoins service : ${agentsToBuyCoins.message}");
    } else {
      throw Exception("agentsToBuyCoins Service: Failed to get agentsToBuyCoins");
    }

    return agentsToBuyCoins;
  }

  
}