import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/http/httpService.dart';

import 'package:locteca/model/coinRecord.dart';
import 'package:locteca/model/userCoinRecord.dart';
import 'package:locteca/model/userLogin.dart';
import 'package:locteca/repository/userAuthRepository.dart';

class CoinRecordService{
   UserAuthRepository userAuthRepository = UserAuthRepository();
  UserLogin userLogin;
  HttpService httpService = new HttpService.internal();
  Map<String, String> _getRequestHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${userLogin.data.token}'
    };
  }


  Future<CoinRecord> getCoinRecord() async {
    CoinRecord coinRecord;

 

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

    // String completeUrlForPayCheck = APIConstants.getPayCheckEndpoint +
    //     "FromDate=" +
    //     fromDate +
    //     "&ToDate=" +
    //     toDate;
    final http.Response response = await httpService.getRequestWithAccessToken(
        endPoint: APIConstants.coinsRecordEndPoint, header: _getRequestHeaders());
    print("status code ${response.statusCode}");

    if (response. statusCode == 200) {
      print("response body  in coinRecord service : : ${response.body}");

      var json = jsonDecode(response.body);

      coinRecord = CoinRecord.fromJson(json);

      print("response body  in coinRecord service : ${coinRecord.message}");
    } else {
      throw Exception("coinRecord Service: Failed to get coinRecord");
    }

    return coinRecord;
  }

   Future<UserCoinRecord> getUserCoinRecord() async {
    UserCoinRecord userCoinRecord;

 

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

    // String completeUrlForPayCheck = APIConstants.getPayCheckEndpoint +
    //     "FromDate=" +
    //     fromDate +
    //     "&ToDate=" +
    //     toDate;
    final http.Response response = await httpService.getRequestWithAccessToken(
        endPoint: APIConstants.userCoinsRecordEndPoint, header: _getRequestHeaders());
    print("status code ${response.statusCode}");

    if (response. statusCode == 200) {
      print("response body  in userCoinRecord service : : ${response.body}");

      var json = jsonDecode(response.body);

      userCoinRecord = UserCoinRecord.fromJson(json);

      print("response body  in userCoinRecord service : ${userCoinRecord.message}");
    } else {
      throw Exception("userCoinRecord Service: Failed to get userCoinRecord");
    }

    return userCoinRecord;
  }

  
}