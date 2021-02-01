import 'package:locteca/model/userLogin.dart';
import 'package:locteca/service/userSignUpService.dart';

class UserSignUpRepository {
  UserSignUpService userSignUpService = UserSignUpService();
  Future<UserLogin> registerNewUser(
      String name, String email, String password, String role) async {
    UserLogin userLogin =
        await userSignUpService.registerNewUser(name, email, password, role);

    return userLogin;
  }
}
