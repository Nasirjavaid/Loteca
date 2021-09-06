import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/http/httpService.dart';
import 'package:locteca/model/feedback.dart';

import 'package:locteca/model/userLogin.dart';
import 'package:locteca/repository/userAuthRepository.dart';

class FeedbackService {
  UserLogin userLogin;

  HttpService httpService = new HttpService.internal();

  Map<String, String> _getRequestHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${userLogin.data.token}'
    };
  }

  Future<Feedback> postFeedback(String body, String type) async {
    Feedback feedback;

    UserAuthRepository userAuthRepository = UserAuthRepository();

    userLogin = await userAuthRepository.getUserDataFromSharedPrefrences();

    Map<String, dynamic> requestBody = <String, dynamic>{
      'body': body,
      'type': type,
    };
    final http.Response response = await httpService.postRequestWithToken(
        endPoint: APIConstants.feedBackEndPoint,
        header: _getRequestHeaders(),
        data: requestBody);
    print("status code ${response.statusCode}");

    if (response.statusCode == 200) {
      print("response body  in feedback : : ${response.body}");

      var json = jsonDecode(response.body);

      feedback = Feedback.fromJson(json);

      print("response body  in feedback : ${feedback.message}");
    } else if (response.statusCode == 404) {
      var json = jsonDecode(response.body);

      feedback = Feedback.fromJson(json);
    } else if (response.statusCode == 209) {
      var json = jsonDecode(response.body);

      feedback = Feedback.fromJson(json);
    } else {
      throw Exception("feedback Service: Failed to feedback");
    }

    return feedback;
  }
}
