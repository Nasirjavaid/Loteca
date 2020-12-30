import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/http/httpService.dart';
import 'package:locteca/model/userLogin.dart';


class UserSignUpService {
  Future<UserLogin> registerNewUser(String name, String email, String password,
      String phone, String address) async {
    UserLogin usersLogin = new UserLogin();

    HttpService httpService = new HttpService.internal();

    Map<String, String> requestBody = <String, String>{
      'customer_name': name,
      'email': email,
      'mobile': phone,
      'Address': address,
      'password': password,
    };

    final http.Response response = await httpService.postRequest(
       endPoint: APIConstants.baseUrl, data:requestBody);

    if (response.statusCode == 200) {
      print("response body  in user SignUp: ${response.body}");

      var json = jsonDecode(response.body);

      usersLogin = UserLogin.fromJson(json);
    } else if (response.statusCode == 400) {
      var json = jsonDecode(response.body);
         print("response body  in user SignUp: ${response.body}");

      // if (json['data'] is String) {
      //   usersLogin.message = json['data'];
      //   usersLogin.status = "failed";
      // }

      // usersLogin = UserLogin.fromJson(json);
    } else {
      throw Exception("UserSignLogin service: Failed to Register new User");
    }

    return usersLogin;
  }
}
