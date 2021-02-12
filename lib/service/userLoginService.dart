import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/http/httpService.dart';
import 'package:locteca/model/userLogin.dart';


class UserLoginService {
  Future<UserLogin> getUser(String username,String password) async {
    UserLogin usersLogin;

    HttpService httpService = new HttpService.internal();

    

   
    

  //    Map<String, String> requestBody = <String,String>{
  //    'email':username,
  //    'password':password,
   
  // };

  String completeUrlForLogin = APIConstants.userLoginEndPoint+ 'email='+username+'&password='+password;

    final http.Response response =
        await httpService.postRequest(endPoint:completeUrlForLogin,);

    if (response.statusCode == 200) {
      print("response body  in user login: ${response.body}");

      var json = jsonDecode(response.body);

      usersLogin = UserLogin.fromJson(json);
    } else if (response.statusCode >= 400) {
      return null;
    } else {
      throw Exception("UserLogin service: Failed to get User");
    }

    return usersLogin;
  }
}
