import 'package:locteca/model/leaguesModel.dart';
import 'package:locteca/model/mainRound.dart';
import 'package:locteca/service/leaguesService.dart';

class LeaguesRepository {
  LeaguesService leaguesService = LeaguesService();
  Future<LeaguesModel> getLeagues() async {
//custom delay
    // await Future.delayed(Duration(seconds: 1));

    LeaguesModel leaguesModel = LeaguesModel();

    leaguesModel = await leaguesService.getLeagues();

    if (leaguesModel != null) {
      return leaguesModel;
    }
    return null;
  }

  Future<MainRound> getActiveLeagueDetail(int roundId) async {
//custom delay
    // await Future.delayed(Duration(seconds: 1));

    MainRound mainRound = MainRound();

    mainRound = await leaguesService.getActiveLeagueDetail(roundId);

    // if (mainRound != null) {
    //   return mainRound;
    // }
    return mainRound;
  }
}
