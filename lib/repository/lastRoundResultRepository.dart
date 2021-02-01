import 'package:locteca/model/lastRoundResult.dart';
import 'package:locteca/service/lastRoundResultService.dart';

class LastRoundResultRepository {
  Future<LastRoundResult> getLastRoundResult() async {
//custom delay
    // await Future.delayed(Duration(seconds: 1));

    LastRoundResult lastRoundResult = LastRoundResult();
    LastRoundResultService lastRoundResultService = LastRoundResultService();

    lastRoundResult = await lastRoundResultService.getLastRoundResult();

    if (lastRoundResult != null) {
      return lastRoundResult;
    }
    return null;
  }
}
