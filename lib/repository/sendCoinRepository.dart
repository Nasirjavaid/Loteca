import 'package:locteca/model/sendCoin.dart';
import 'package:locteca/model/validateUser.dart';
import 'package:locteca/service/sendCoinService.dart';

class SendCoinRepository {
  SendCoinService sendCoinService = SendCoinService();
  Future<ValidateUser> valiodateUser(String email) async {
//custom delay
    // await Future.delayed(Duration(seconds: 1));

    ValidateUser validateUser = ValidateUser();

    validateUser = await sendCoinService.validateUser(email);

    if (validateUser != null) {
      return validateUser;
    }
    return null;
  }

  Future<SendCoin> sendCoin(String email, String coins) async {
//custom delay
    // await Future.delayed(Duration(seconds: 1));

    SendCoin sendCoin = SendCoin();

    sendCoin = await sendCoinService.sendCoins(email, coins);

    if (sendCoin != null) {
      return sendCoin;
    }
    return null;
  }
}
