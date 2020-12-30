import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  static final HttpService instance = HttpService.internal();

  HttpService.internal();
  factoryHttpService() {
    return instance;
  }

  // String _authToken;
  // Map<String, String> _getRequestHeaders() {
  //   return {'Authorization': 'Bearer $_authToken'};
  // }

  Future<http.Response> getRequest(String endPoint) {
    String url = endPoint;
    print("_get request : $url");
    return http.get(url);
  }

  Future<http.Response> postRequest(
      {String endPoint, Map<dynamic, dynamic> data}) {
    String url = endPoint;
    return http.post(url, body: data, encoding: Encoding.getByName("utf-8"));
  }

  // Map<String, dynamic> _convertJsonToMap(String response) {
  //   return json.decode(response);
  // }

  // Get Json Posts

  // Future<List<User>> getUsersPosts() async {
  //   String endpoint = "/posts";

  //   List<User> usersList;

  //   final http.Response response = await _get(endpoint);

  //   if (response.statusCode == 200) {
  //     print("response: ${response.body}");

  //     var json = jsonDecode(response.body);

  //     usersList = (json as List).map((model) => User.fromJson(model)).toList();
  //   } else {
  //     throw Exception("Failed to load post");
  //   }

  //   return usersList;
  // }
}
