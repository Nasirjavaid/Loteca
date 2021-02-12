import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/http/httpService.dart';
import 'package:locteca/model/userLogin.dart';

class UserSignUpService {
  Future<UserLogin> registerNewUser(
      String name,
      String email,
      String mobileNumber,
      String whatsAppNumber,
      String password,
      String role) async {
    UserLogin usersLogin = new UserLogin();

    HttpService httpService = new HttpService.internal();

    Map<String, String> requestBody = <String, String>{
      'email': email,
      'password': password,
      'name': name,
      'role': role,
      'phone': mobileNumber,
      'whatsapp_phone': whatsAppNumber,
    };

    // String completeSignUpUrl = APIConstants.userSignUpEndPoint +
    //     "name=" +
    //     name +
    //     "&email=" +
    //     email +
    //     "&password=" +
    //     password +
    //     "&role=" +
    //     role;
//http://phpstack-526382-1675862.cloudwaysapps.com/api/register?name=User5&email=user7@email.com&password=Hello123&role=1
    final http.Response response = await httpService.postRequest(
        endPoint: APIConstants.userSignUpEndPoint, data: requestBody);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("response body  in user SignUp: ${response.body}");

      var json = jsonDecode(response.body);

      usersLogin = UserLogin.fromJson(json);
    } else if (response.statusCode > 400) {
      var json = jsonDecode(response.body);
      print("response body  in user SignUp: ${response.body}");
      usersLogin = UserLogin.fromJson(json);
      // if (json['data'] is String) {
      //   usersLogin.message = json['data'];
      //   usersLogin.status = "failed";
      // }

      // usersLogin = UserLogin.fromJson(json);
    } else {
      throw Exception("UserSign up service: Failed to Register new User");
    }

    return usersLogin;
  }
}
