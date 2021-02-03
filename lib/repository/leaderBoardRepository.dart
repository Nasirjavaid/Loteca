import 'package:locteca/model/leaderBoard.dart';
import 'package:locteca/service/leaderBoardService.dart';

class LeaderBoardRepository {
  Future<LeaderBoardModel> getLeaderBoard() async {
//custom delay
    // await Future.delayed(Duration(seconds: 1));

    LeaderBoardModel leaderBoardModel = LeaderBoardModel();
    LeaderBoardService leaderBoardService = LeaderBoardService();

    leaderBoardModel = await leaderBoardService.geleaderboard();

    if (leaderBoardModel != null) {
      return leaderBoardModel;
    }
    return null;
  }
}
