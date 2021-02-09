import 'package:locteca/model/userLogin.dart';
import 'package:locteca/service/userSignUpService.dart';

class UserSignUpRepository {
  UserSignUpService userSignUpService = UserSignUpService();
  Future<UserLogin> registerNewUser(
      String name, String email,String mobileNumber,String whatsAppNumber, String password, String role) async {
    UserLogin userLogin =
        await userSignUpService.registerNewUser(name, email,mobileNumber,whatsAppNumber, password, role);

    return userLogin;
  }
}
