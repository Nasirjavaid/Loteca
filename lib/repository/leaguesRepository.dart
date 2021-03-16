import 'package:locteca/model/closedLeague.dart';
import 'package:locteca/model/leaguesModel.dart';
import 'package:locteca/model/mainRound.dart';
import 'package:locteca/model/participatedLeagues.dart';
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

  Future<ClosedLeague> getClosedLeagueDetail(int roundId) async {
//custom delay
    // await Future.delayed(Duration(seconds: 1));

    ClosedLeague closedLeague = ClosedLeague();

    closedLeague = await leaguesService.getClosedLeagueDetail(roundId);

    // if (mainRound != null) {
    //   return mainRound;
    // }
    return closedLeague;
  }

  Future<ParticipatedLeague> getParticipatedLeagues() async {
//custom delay
    // await Future.delayed(Duration(seconds: 1));

    ParticipatedLeague participatedLeague = ParticipatedLeague();

    participatedLeague = await leaguesService.getParticipatedLeagues();

    // if (participatedLeague != null) {
    //   return participatedLeague;
    // }
    return participatedLeague;
  }
}
