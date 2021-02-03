import 'package:locteca/model/leaguesModel.dart';
import 'package:locteca/service/leaguesService.dart';

class LeaguesRepository {
  Future<LeaguesModel> getLeagues() async {
//custom delay
    // await Future.delayed(Duration(seconds: 1));

    LeaguesModel leaguesModel = LeaguesModel();
    LeaguesService leaguesService = LeaguesService();

    leaguesModel = await leaguesService.getLeagues();

    if (leaguesModel != null) {
      return leaguesModel;
    }
    return null;
  }
}