import 'package:locteca/model/mainRound.dart';
import 'package:locteca/service/createMyLeagueService.dart';

class CreateMyLeagueRepository {
  Future<MainRound> createMyLeague(String leagueName) async {
//custom delay
    // await Future.delayed(Duration(seconds: 1));

    MainRound mainRound = MainRound();
    CreateMyLeagueService createMyLeagueService =
        CreateMyLeagueService();

    mainRound = await createMyLeagueService.createMyLeague(leagueName);

    if (mainRound != null) {
      return mainRound;
    }
    return null;
  }
}
