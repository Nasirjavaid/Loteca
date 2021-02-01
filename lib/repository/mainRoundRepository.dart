import 'package:locteca/model/mainRound.dart';
import 'package:locteca/service/mainRoundService.dart';

class MainRoundRepository {
  Future<MainRound> getMainRound() async {
//custom delay
    // await Future.delayed(Duration(seconds: 1));

    MainRound mainRound = MainRound();
    MainRoundService mainRoundService = MainRoundService();

    mainRound = await mainRoundService.getMainRound();

    if (mainRound != null) {
      return mainRound;
    }
    return null;
  }

  Future<MainRound> submitBetOfMainRound(MainRound mainRound) async {
//custom delay
    // await Future.delayed(Duration(seconds: 1));

    MainRound mainRoundInner = MainRound();

    MainRoundService mainRoundService = MainRoundService();

   var dataString = mainRound.toJson().toString();
   print("$dataString");
    mainRoundInner = await mainRoundService.subMitBetOfMainRound(
        mainRound.round.id, dataString);

    if (mainRoundInner != null) {
      return mainRoundInner;
    }
    return null;
  }
}
