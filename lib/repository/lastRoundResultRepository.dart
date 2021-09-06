import 'package:locteca/model/lastRoundResult.dart';
import 'package:locteca/model/roundDetail.dart';
import 'package:locteca/service/lastRoundResultService.dart';

class LastRoundResultRepository {
  LastRoundResult lastRoundResult = LastRoundResult();
  RoundDetail roundDetail = RoundDetail();
  LastRoundResultService lastRoundResultService = LastRoundResultService();
  Future<LastRoundResult> getLastRoundResult() async {
//custom delay
    // await Future.delayed(Duration(seconds: 1));

    lastRoundResult = await lastRoundResultService.getLastRoundResult();

    if (lastRoundResult != null) {
      return lastRoundResult;
    }
    return null;
  }

  Future<RoundDetail> getRoundDetail(int roundId) async {
//custom delay
    // await Future.delayed(Duration(seconds: 1));

    roundDetail = await lastRoundResultService.getRoundDetail(roundId);

    if (roundDetail != null) {
      return roundDetail;
    }
    return null;
  }
}
