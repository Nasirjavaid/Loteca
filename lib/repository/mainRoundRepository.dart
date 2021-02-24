import 'package:locteca/model/mainRound.dart';
import 'package:locteca/service/mainRoundService.dart';

class MainRoundRepository {
  Future<MainRound> getMainRound() async {
//custom delay
    // await Future.delayed(Duration(seconds: 1));

    MainRound mainRound = MainRound();
    MainRoundService mainRoundService = MainRoundService();

    mainRound = await mainRoundService.getMainRound();

    // if (mainRound != null) {
    //   return mainRound;
    // }
     return mainRound;
  }

  Future<MainRound> submitBetOfMainRound(MainRound mainRound) async {
//custom delay
    // await Future.delayed(Duration(seconds: 1));

    MainRound mainRoundInner = MainRound();

    MainRoundService mainRoundService = MainRoundService();


    List<String> slectedAnswers = [];
    mainRound.round.games.forEach((element) {
      slectedAnswers.add(element.userSelctedTeamOrAnswer);
    });

     List<int> slectedGamesId = [];
    mainRound.round.games.forEach((element) {
      slectedGamesId.add(element.id);
    });

    int selectedPackageId = mainRound.round.selectedPackageId;

   
 final input = slectedGamesId.toString();
  final removedBracketsFromGameIds = input.substring(1, input.length - 1);
  // final parts = removedBrackets.split(', ');
  
  // var joined = parts.map((part) => "'$part'").join(', ');
  
  // print(joined);


    mainRoundInner = await mainRoundService.subMitBetOfMainRound(
        mainRound.round.id, slectedAnswers.toString(),removedBracketsFromGameIds,selectedPackageId);

    if (mainRoundInner != null) {
      return mainRoundInner;
    }
    return null;
  }
}
