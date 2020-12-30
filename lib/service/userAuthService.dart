
import 'package:http/http.dart' as http;
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/http/httpService.dart';
import 'package:locteca/model/userLogin.dart';



class UserAuthService {
  Future<UserLogin> getUserToken(String customerId) async {
      UserLogin usersLogin;
  
      HttpService httpService = new HttpService.internal();
  
      Map<String, String> requestBody = <String, String>{
        'Customerid': customerId,
      };
  
      final http.Response response = await httpService.postRequest(
         endPoint: APIConstants.userTokenValidationEndPoint, data:requestBody);
  
      // if (response.statusCode == 200) {
      //   print("response body  in user Auth Service: ${response.body}");
  
      //   var json = jsonDecode(response.body);
  
      //   usersLogin = UserLogin.fromJson(json);
      // } else {
      //   throw Exception("Auth Service: Failed to get User Token");
      // }
  
      return usersLogin;
    }
  }
  

