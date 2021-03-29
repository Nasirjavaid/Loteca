import 'package:locteca/model/passwordRecovery.dart';
import 'package:locteca/model/sendCoin.dart';
import 'package:locteca/service/passwordRecoveryService.dart';


class PasswordRecoveryRepository {
  PasswordRecoveryService passwordRecoveryService = PasswordRecoveryService();
  Future<PasswordRecovery> validateEmailToSendPasswordResetCode(String email) async {
//custom delay
    // await Future.delayed(Duration(seconds: 1));

    PasswordRecovery passwordRecovery = PasswordRecovery();

    passwordRecovery = await passwordRecoveryService.validateEmailToSendPasswordResetCode(email);

   
    return passwordRecovery;
  }

  Future<PasswordRecovery> updatePassword(String email, String password) async {
//custom delay
    // await Future.delayed(Duration(seconds: 1));

      PasswordRecovery passwordRecovery = PasswordRecovery();

    passwordRecovery = await passwordRecoveryService.updatePassword(email, password);

   
    return passwordRecovery;
  }
}
