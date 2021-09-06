// Padding(
//                   padding: const EdgeInsets.only(top: 2.0, right: 2),
//                   child: Container(
//                       decoration: BoxDecoration(
//                           color: AppTheme.appCardColor,
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(20.0),
//                             topRight: Radius.circular(20.0),
//                             bottomLeft: Radius.circular(20.0),
//                             bottomRight: Radius.circular(20.0),
//                           )),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.flag,
//                               size: 16,
//                               color: Colors.white,
//                             ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Expanded(
//                               child: mainRound.userAnswers[index].answer ==
//                                       mainRound.round.games[index].teamA
//                                   ? Text(
//                                       mainRound.userAnswers[index].answer,
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .bodyText1
//                                           .copyWith(
//                                               color: Colors.white60,
//                                               fontWeight: FontWeight.w700,
//                                               fontSize: 9),
//                                     )
//                                   : mainRound.userAnswers[index].answer ==
//                                           mainRound.round.games[index].teamB
//                                       ? Text("")
//                                       : Text("Draw"),
//                             ),
//                           ],
//                         ),
//                       )),
//                 );