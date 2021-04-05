import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:anitex/anitex.dart' as anitext;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:locteca/bloc/mainRoundBloc/mainRoundBloc.dart';
import 'package:locteca/bloc/mainRoundBloc/mainRoundEvent.dart';
import 'package:locteca/bloc/mainRoundBloc/mainRoundState.dart';
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locteca/config/methods.dart';
import 'package:locteca/config/networkConnectivity.dart';
import 'package:locteca/model/mainRound.dart';
import 'package:locteca/ui/CommonWidget/commonWidgets.dart';
import 'package:locteca/ui/CommonWidget/loadingIndicator.dart';
import 'package:locteca/ui/CommonWidget/roundedImageViewWithoutBorderDynamic.dart';
import 'package:locteca/ui/Screen/DashboardScreen/myNavDrawer.dart';
import 'package:locteca/ui/Screen/MakeBet/NoRoundLiveWidget.dart';
import 'package:easy_localization/easy_localization.dart';

class MakeBetMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) {
          return MainRoundBloc()
            ..add(GetMainRoundEvent(
              mainRoundCallDirection: 1,
            ));
        },
        child: MakeBet(),
      ),
    );
  }
}

class MakeBet extends StatefulWidget {
  @override
  _MakeBetState createState() => _MakeBetState();
}

class _MakeBetState extends State<MakeBet> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String teamADummyImage =
      "https://png.pngtree.com/png-clipart/20200309/ourmid/pngtree-multicolored-soccer-ball-with-a-golden-crown-and-national-team-flags-png-image_2156370.jpg";
  String teamBDummyImage =
      "https://png.pngtree.com/png-clipart/20200227/ourmid/pngtree-red-and-orange-football-fan-pipes-with-national-team-flags-3d-png-image_2154419.jpg";

  bool widegtSwitch0 = false;
  bool widegtSwitch1 = false;
  bool widegtSwitch2 = false;
  int selectedPackageId = 0;
  int globalUserCoinsValue = 0;
  String selectedPackageAccumulativePrice;
  MainRound mainRoundGlobal;

  void showMessageError(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: color,
      content: new Text(
        message,
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      duration: const Duration(seconds: 3),
    ));
  }

  Widget actionWidget(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              BlocProvider.of<MainRoundBloc>(context).add(GetMainRoundEvent(
                mainRoundCallDirection: 1,
              ));
            }));
  }

  void submitBetRequest(MainRound mainRound) {
    if (mainRound.user.emailVerifiedAt == null) {
      Methods.showDialogForEmailVerification(
        context,
      );
    } else {
      if (mainRound.user.coins == 0 || mainRound.user.coins == null) {
        //show message with no coins error
        //  showMessageError("You dont have enough coins.");
        noEnoughCoinsWidget();
        print("Request not Submitted... Dont have enough coins");
      } else if (selectedPackageId == null || selectedPackageId == 0) {
        // show error message to select a participation fee package
        print(
            "Request not Submitted... did not selected the participation fee");
        showMessageError(
          "Please select your bet fee".tr().toString(),
        );
      } else {
        bool checkPoint = true;
        for (int i = 0; i < mainRound.round.games.length; i++) {
          if (mainRound.round.games[i].widegtSwitch0 == false &&
              mainRound.round.games[i].widegtSwitch1 == false &&
              mainRound.round.games[i].widegtSwitch2 == false) {
            //show error to slect all the team winners/losser/or draw
            showMessageError(
              "Must select your choice from All team listed above"
                  .tr()
                  .toString(),
            );
            print(
                "Request not Submitted beacue team ${mainRound.round.games[i].name} is not selected");
            checkPoint = false;
            break;
          } else if (mainRound.round.games[i].widegtSwitch0 == null &&
              mainRound.round.games[i].widegtSwitch1 == null &&
              mainRound.round.games[i].widegtSwitch2 == null) {
            //show error to slect all the team winners/losser/or draw
            showMessageError(
              "Must select your choice from all the Games listed above"
                  .tr()
                  .toString(),
            );
            print(
                "Request not Submitted beacue team ${mainRound.round.games[i].id} is not selected");
            checkPoint = false;
            break;
          }
        }

        if (checkPoint) {
          //Finally submit the request
          // showMessageError("Bet Submitted Successfully");
          mainRound.round.selectedPackageId = 0;
          mainRound.round.selectedPackageId = selectedPackageId;
          print("Bet Submitted... Successfully");
          BlocProvider.of<MainRoundBloc>(context)
              .add(SubmitBetButtonClickedEvent(
            mainRound: mainRound,
          ));
        }
      }
    }
  }

  bool checkIfAnyTeamIsNotSelected(MainRound mainRound) {
    for (int i = 0; i < mainRound.round.games.length; i++) {
      if (mainRound.round.games[i].widegtSwitch0 == false &&
          mainRound.round.games[i].widegtSwitch1 == false &&
          mainRound.round.games[i].widegtSwitch0 == false) {
        //show error to slect all the team winners/losser/or draw
        break;
      } else if (mainRound.round.games[i].widegtSwitch0 == null &&
          mainRound.round.games[i].widegtSwitch1 == null &&
          mainRound.round.games[i].widegtSwitch0 == null) {
        //show error to slect all the team winners/losser/or draw
        break;
      } else {
        //finally submit the bet request
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.appDefaultColor,
      child: SafeArea(
        maintainBottomViewPadding: true,
        child: Scaffold(
          key: _scaffoldKey,
          extendBodyBehindAppBar: true,
          // appBar: AppBar(
          //   iconTheme: IconThemeData(color: Colors.white38),

          //   elevation: 0.0,
          //   actions: [
          //     actionWidget(context),
          //   ],
          //   // toolbarHeight: 50,
          //   centerTitle: true,
          //   // backgroundColor: AppTheme.appDefaultColor,
          //   backgroundColor: Colors.transparent,
          //   // title: Text(
          //   //   "Loteca",
          //   //   style:
          //   //       Theme.of(context).textTheme.button.copyWith(color: Colors.white),
          //   // ),
          // ),
          backgroundColor: AppTheme.appDefaultColor,
          body: _buildBody(context),
          drawer: MyNaveDrawerMain(),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
// return BlocConsumer<MainRoundBloc, MainRoundState>(
//       buildWhen: (previousState, state) {
//         return state is! DontBuild;
//       },
//       builder: (BuildContext context, state) {
//         return Text(state.text);
//       },
//       listener: (BuildContext context, state) {
//         if (state is ShowFlushbar) {

//         }
//       },
//     );

    return BlocListener<MainRoundBloc, MainRoundState>(listener:
        (context, state) {
      if (state is MainRoundFailureState) {
        showMessageError("${state.errorMessage}");

        print("Error : ${state.errorMessage}");
      }
      // if(state is MainRoundUpdateWidgetState){

      // }
      if (state is MainRoundSuccessState) {
        if (state.mainRound.bid) {
          widegtSwitch0 = false;
          widegtSwitch1 = false;
          widegtSwitch2 = false;
          selectedPackageId=0;
          Methods.showDialogueForUserBetDetail(context, state.mainRound, null);
        }
      }
    }, child:
        BlocBuilder<MainRoundBloc, MainRoundState>(builder: (context, state) {
      if (state is MainRoundSuccessState) {
        mainRoundGlobal = MainRound();
        mainRoundGlobal = state.mainRound;

        return bodyTwoCurrentDesign(state);
      }

      if (state is MainRoundInProgressState) {
        return LoadingIndicator(Colors.white);
      }
      if (state is MainRoundFailureState) {
        return failedWidget(context);
      }

      if (state is NoLiveRoundAvailableMainRoundState) {
        return noLiveRoundWidgetHere(context, state.errorMessage);
      }

      if (state is MainRoundBetSubmitingInProgressState) {
        return bodyTwoCurrentDesign(
          state,
        );
      }

      return Container(color: Colors.white);
    }));
  }

  Widget body1_previousDesign(state) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.014,
          ),
          liveTeamTagWidget(context),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.024,
          ),
          teamNameText(context, mainRoundGlobal),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.024,
          ),
          listofTeams(context, mainRoundGlobal),
          Spacer(),
          bottomCard(context, mainRoundGlobal, state),
        ],
      ),
    );
  }

  Widget bodyTwoCurrentDesign(state) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
              // pinned: true,
              snap: true,
              floating: true,
              leading: Container(),
              toolbarHeight: 56,
              flexibleSpace: AppBar(
                iconTheme: IconThemeData(color: Colors.white38),
                elevation: 0.0,
                centerTitle: true,
                backgroundColor: AppTheme.appDefaultColor,
                title: liveTeamTagWidget(context),
                actions: [
                  actionWidget(context),
                ],
              ),
            ),
            SliverToBoxAdapter(
                child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.024,
                ),
                state is MainRoundBetSubmitingInProgressState
                    ? teamNameText(context, mainRoundGlobal)
                    : teamNameText(context, state.mainRound),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.024,
                ),
              ],
            )),
            state is MainRoundBetSubmitingInProgressState
                ? listofTeams(context, mainRoundGlobal)
                : listofTeams(context, state.mainRound),
            SliverToBoxAdapter(
                child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.30,
                ),
              ],
            )),
          ],
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: state is MainRoundBetSubmitingInProgressState
                ? bottomCard(context, mainRoundGlobal, state)
                : bottomCard(context, state.mainRound, state),
          ),
        ),
      ],
    );
  }

  Widget failedWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white38),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: AppTheme.appDefaultColor,
        title: Text(
          "Loteca 2.0",
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.white54),
        ),
        actions: [
          actionWidget(context),
        ],
      ),
      body: FlatButton(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child:
                    Icon(Icons.refresh, size: 60, color: AppTheme.nearlyBlue),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Tap to reload".tr().toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white54),
              ),
            ],
          ),
        ),
        onPressed: () {
          BlocProvider.of<MainRoundBloc>(context).add(GetMainRoundEvent(
            mainRoundCallDirection: 1,
          ));
        },
      ),
      drawer: MyNaveDrawerMain(),
    );
  }

  Widget noLiveRoundWidgetHere(BuildContext context, String errorMessage) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white38),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: AppTheme.appDefaultColor,
        title: Text(
          "Loteca 2.0",
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.white54),
        ),
        actions: [
          actionWidget(context),
        ],
      ),
      body: FlatButton(
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: noLiveRoundWidget(context, errorMessage)),
        onPressed: () {
          BlocProvider.of<MainRoundBloc>(context).add(GetMainRoundEvent(
            mainRoundCallDirection: 1,
          ));
        },
      ),
      drawer: MyNaveDrawerMain(),
    );
  }

  Widget liveTeamTagWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.background1,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 22),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 30.0,
              child: ScaleAnimatedTextKit(
                repeatForever: true,
                duration: const Duration(milliseconds: 1000),
                onTap: () {
                  print("Tap Event");
                },
                text: [
                  "LIVE".tr().toString(),
                ],
                textStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: AppTheme.appDefaultColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                    ),
                // textStyle: TextStyle(fontSize: 14.0, fontFamily: "Canterbury"),
                textAlign: TextAlign.start,
              ),
            ),

            // Text("LIVE",
            //     style: Theme.of(context).textTheme.bodyText2.copyWith(
            //         color: AppTheme.appDefaultColor,
            //         fontSize: 14,
            //         fontWeight: FontWeight.w900)),
            SizedBox(
              width: 14,
            ),
            Icon(
              FontAwesomeIcons.dotCircle,
              size: 16,
              color: AppTheme.appDefaultColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget teamNameText(BuildContext context, MainRound mainRound) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Icon(Icons.circle, size: 10, color: Colors.green[300]),
            SizedBox(
              width: 5,
            ),
            Column(children: [
              Text(
                "Start Date".tr().toString(),
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.white60,
                    fontSize: 9,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 1,
              ),
              Text(
                mainRound.round.startingDate.isEmpty
                    ? "---"
                    : "${mainRound.round.startingDate}",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.white60,
                    fontSize: 10,
                    fontWeight: FontWeight.w900),
              ),
            ]),
          ],
        ),
        Text(
          mainRound == null || mainRound == " "
              ? "---"
              : "${mainRound.round.name}",
          style: Theme.of(context).textTheme.bodyText2.copyWith(
              color: Colors.white60, fontSize: 16, fontWeight: FontWeight.w900),
        ),
        Row(
          children: [
            Icon(Icons.circle, size: 10, color: Colors.red[300]),
            SizedBox(
              width: 5,
            ),
            Column(children: [
              Text(
                "End Date".tr().toString(),
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.white60,
                    fontSize: 9,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 1,
              ),
              Text(
                mainRound == null || mainRound == " "
                    ? "---"
                    : "${mainRound.round.endingDate}",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.white60,
                    fontSize: 10,
                    fontWeight: FontWeight.w900),
              ),
            ]),
          ],
        ),
      ],
    );
  }

  Widget listofTeams(BuildContext context, MainRound mainRound) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return listWiewItemCard(context, mainRound, index);
        },
        childCount: mainRound == null
            ? mainRoundGlobal.round.games.length
            : mainRound.round.games.length,

        //  ListView.builder(
        //     padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
        //     itemCount: mainRound.round.games.length,
        //     scrollDirection: Axis.vertical,
        //     //reverse: true,
        //     itemBuilder: (BuildContext context, int index) {

        //       return listWiewItemCard(context, mainRound, index);
        //     }),
      ),
    );
  }

  Widget listWiewItemCard(
      BuildContext context, MainRound mainRound, int index) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 1.5),
        child: Container(
            decoration: BoxDecoration(
                color: AppTheme.appDefaultColor2,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                )),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  teamNameAndMatchStartingDate(
                      context,
                      mainRound.round.games[index].name,
                      mainRound.round.games[index].happeningDate),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (mainRound.user.emailVerifiedAt == null) {
                                Methods.showDialogForEmailVerification(
                                  context,
                                );
                              } else {
                                setState(() {
                                  mainRound.round.games[index].widegtSwitch0 =
                                      true;
                                  mainRound.round.games[index].widegtSwitch1 =
                                      false;
                                  mainRound.round.games[index].widegtSwitch2 =
                                      false;
                                });
                                print(
                                    "(Game id is ${mainRound.round.games[index].id}) and User selected Answer  => ${mainRound.round.games[index].userSelctedTeamOrAnswer = mainRound.round.games[index].teamA}");
                                print("TeamA clicked");
                              }
                            },
                            child: mainRound.round.games[index].widegtSwitch0 ==
                                        false ||
                                    mainRound
                                            .round.games[index].widegtSwitch0 ==
                                        null
                                ? teamNameContainerNormal(
                                    mainRound.round.games[index].teamA,
                                    mainRound.round.games[index].flagA)
                                : selectedTeamNameContainer(
                                    mainRound.round.games[index].teamA,
                                    mainRound.round.games[index].flagA),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                              onTap: () {
                                if (mainRound.user.emailVerifiedAt == null) {
                                  Methods.showDialogForEmailVerification(
                                    context,
                                  );
                                } else {
                                  setState(() {
                                    mainRound.round.games[index].widegtSwitch0 =
                                        false;
                                    mainRound.round.games[index].widegtSwitch1 =
                                        true;
                                    mainRound.round.games[index].widegtSwitch2 =
                                        false;
                                  });

                                  print("Draw clicked");

                                  print(
                                      "(Game id is ${mainRound.round.games[index].id}) and User selected Answer => ${mainRound.round.games[index].userSelctedTeamOrAnswer = "Draw"}");
                                }
                              },
                              child:
                                  mainRound.round.games[index].widegtSwitch1 ==
                                              false ||
                                          mainRound.round.games[index]
                                                  .widegtSwitch1 ==
                                              null
                                      ? teamMatchDrawContainerNormal()
                                      : selectedTeamMatchDrawContainer()),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (mainRound.user.emailVerifiedAt == null) {
                                Methods.showDialogForEmailVerification(
                                  context,
                                );
                              } else {
                                setState(() {
                                  mainRound.round.games[index].widegtSwitch0 =
                                      false;
                                  mainRound.round.games[index].widegtSwitch1 =
                                      false;
                                  mainRound.round.games[index].widegtSwitch2 =
                                      true;
                                  print(
                                      "(Game id is ${mainRound.round.games[index].id}) and User selected Answer => ${mainRound.round.games[index].userSelctedTeamOrAnswer = mainRound.round.games[index].teamB}");
                                });

                                print("TeamB clicked");
                              }
                            },
                            child: mainRound.round.games[index].widegtSwitch2 ==
                                        false ||
                                    mainRound
                                            .round.games[index].widegtSwitch2 ==
                                        null
                                ? teamNameContainerNormalRightFlag(
                                    mainRound.round.games[index].teamB,
                                    mainRound.round.games[index].flagB)
                                : selectedTeamNameContaineRightFlag(
                                    mainRound.round.games[index].teamB,
                                    mainRound.round.games[index].flagB),
                          ),
                        ),
                      ]),
                ],
              ),
            )));
  }

  Widget teamNameContainerNormal(String teamName, String imageUrl) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                children: [
                  RoundedCornerImageViewWithoutBorderDynamic(
                    height: 25,
                    width: 25,
                    imageLink: APIConstants.baseUrlToloadGameFlags + imageUrl,
                    borderWidth: 0.0,
                    cornerRadius: 5,
                  ),
                  // Icon(
                  //   Icons.flag,
                  //   size: 16,
                  //   color: Colors.white,
                  // ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      teamName != null ? "$teamName" : "---",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.white60,
                          fontWeight: FontWeight.w700,
                          fontSize: 9),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget selectedTeamNameContainer(String teamName, String imageUrl) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.30,
      decoration: BoxDecoration(
          color: AppTheme.background1,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                children: [
                  RoundedCornerImageViewWithoutBorderDynamic(
                    height: 25,
                    width: 25,
                    imageLink: APIConstants.baseUrlToloadGameFlags + imageUrl,
                    borderWidth: 0.0,
                    cornerRadius: 5,
                  ),
                  // Icon(
                  //   Icons.flag,
                  //   size: 16,
                  //   color: AppTheme.appDefaultColor,
                  // ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      teamName != null ? "$teamName" : "---",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: AppTheme.appDefaultColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 9),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget teamNameContainerNormalRightFlag(String teamName, String imageUrl) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      teamName != null ? "$teamName" : "---",
                      maxLines: 2,
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.white60,
                          fontWeight: FontWeight.w700,
                          fontSize: 9),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  RoundedCornerImageViewWithoutBorderDynamic(
                    height: 25,
                    width: 25,
                    imageLink: APIConstants.baseUrlToloadGameFlags + imageUrl,
                    borderWidth: 0.0,
                    cornerRadius: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget selectedTeamNameContaineRightFlag(String teamName, String imageUrl) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.30,
      decoration: BoxDecoration(
          color: AppTheme.background1,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      teamName != null ? "$teamName" : "---",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: AppTheme.appDefaultColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 9),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  RoundedCornerImageViewWithoutBorderDynamic(
                    height: 25,
                    width: 25,
                    imageLink: APIConstants.baseUrlToloadGameFlags + imageUrl,
                    borderWidth: 0.0,
                    cornerRadius: 5,
                  ),
                  // newAvater.Avatar(imageUrl:imageUrl ,height: 16,width: 16,circleShow: false,)
                  // Icon(
                  //   Icons.flag,
                  //   size: 16,
                  //   color: AppTheme.appDefaultColor,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget teamMatchDrawContainerNormal() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(
              child: Text(
                "Draw".tr().toString(),
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.white60,
                    fontWeight: FontWeight.w800,
                    fontSize: 8.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget selectedTeamMatchDrawContainer() {
    return Container(
      //width: MediaQuery.of(context).size.width * 0.10,
      decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    FontAwesomeIcons.minusCircle,
                    size: 10,
                    color: AppTheme.lightRed,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Draw".tr().toString(),
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: AppTheme.appDefaultColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 8.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget teamNameAndMatchStartingDate(
      BuildContext context, String teamName, String startingDate) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            Text(
              "Championship".tr().toString() + " :",
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: Colors.white54,
                  fontSize: 9,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              teamName == null || teamName == " " ? "---" : teamName,
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: Colors.white54,
                  fontSize: 10,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(children: [
          Text(
            "Happening Date".tr().toString() + " :",
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: Colors.white54,
                fontSize: 9,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            startingDate == null || startingDate == " " ? "---" : startingDate,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: Colors.white54,
                fontSize: 10,
                fontWeight: FontWeight.w500),
          ),
        ]),
      ]),
    );
  }

  Widget bottomCard(
      BuildContext context, MainRound mainRound, MainRoundState state) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.24,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(75), topRight: Radius.circular(75))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.004,
          ),
          state is MainRoundBetSubmitingInProgressState
              ? CommonWidgets.progressIndicator
              : creditWidget(context, mainRound),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.002,
          ),
          selectAmoutWidget(mainRound),
          Spacer(),

          // BlocBuilder<MainRoundBloc, MainRoundState>(builder: (context, state) {
          //   if (state is MainRoundBetSubmitingInProgressState) {
          //     return CommonWidgets.progressIndicator;
          //   } else {
          //     return submitButton(mainRound);
          //   }
          // }),

          submitButton(mainRound, state),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.002,
          ),
        ],
      ),
    );
  }

  Widget creditWidget(BuildContext context, MainRound mainRound) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.background1,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(FontAwesomeIcons.coins, size: 15, color: AppTheme.nearlyGold),
            SizedBox(
              width: 14,
            ),
            anitext.AnimatedText(
              globalUserCoinsValue == 0
                  ? "${mainRound.user.coins}"
                  : globalUserCoinsValue.toString(),
              duration: const Duration(milliseconds: 500),
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: AppTheme.appDefaultColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectAmoutWidget(MainRound mainRound) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Choose Amount".tr().toString(),
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: AppTheme.appBackgroundColorforCard1,
                        fontSize: 14,
                        fontWeight: FontWeight.w900)),
                Container(
                  height: 1,
                  color: AppTheme.background1,
                  width: MediaQuery.of(context).size.width * 0.55,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    // widegtSwitch0 = true;
                    // widegtSwitch1 = false;
                    // widegtSwitch2 = false;
                    // selectedPackageId = mainRound.round.packages[0].id;
                    // mainRound.round.selectedPackageId =
                    //     mainRound.round.packages[0].id;
                    // selectedPackageAccumulativePrice =
                    //     mainRound.round.packages[0].accumulativePrice;

                    if (mainRound.user.coins <
                        int.parse(
                            mainRound.round.packages[0].participationFee)) {
                      noEnoughCoinsWidget();
                    } else {
// updating User coins value live

                      widegtSwitch0 = true;
                      widegtSwitch1 = false;
                      widegtSwitch2 = false;
                      selectedPackageId = mainRound.round.packages[0].id;
                      mainRound.round.selectedPackageId =
                          mainRound.round.packages[0].id;
                      selectedPackageAccumulativePrice =
                          mainRound.round.packages[0].accumulativePrice;

                      globalUserCoinsValue = 0;
                      globalUserCoinsValue = mainRound.user.coins -
                          int.parse(
                              mainRound.round.packages[0].participationFee);
                    }
                  });
                },
                child: widegtSwitch0 == false
                    ? priceAmountSimpleWidget(mainRound.round.packages[0])
                    : priceAmountSelectedWidget(mainRound.round.packages[0]),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    // widegtSwitch0 = false;
                    // widegtSwitch1 = true;
                    // widegtSwitch2 = false;
                    // selectedPackageId = mainRound.round.packages[1].id;
                    // mainRound.round.selectedPackageId =
                    //     mainRound.round.packages[1].id;
                    // selectedPackageAccumulativePrice =
                    //     mainRound.round.packages[1].accumulativePrice;

                    if (mainRound.user.coins <
                        int.parse(
                            mainRound.round.packages[1].participationFee)) {
                      noEnoughCoinsWidget();
                    }
// updating User coins value live
                    else {
                      widegtSwitch0 = false;
                      widegtSwitch1 = true;
                      widegtSwitch2 = false;
                      selectedPackageId = mainRound.round.packages[1].id;
                      mainRound.round.selectedPackageId =
                          mainRound.round.packages[1].id;
                      selectedPackageAccumulativePrice =
                          mainRound.round.packages[1].accumulativePrice;

                      globalUserCoinsValue = 0;
                      globalUserCoinsValue = mainRound.user.coins -
                          int.parse(
                              mainRound.round.packages[1].participationFee);
                    }
                  });
                },
                child: widegtSwitch1 == false
                    ? priceAmountSimpleWidget(mainRound.round.packages[1])
                    : priceAmountSelectedWidget(mainRound.round.packages[1]),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    // widegtSwitch0 = false;
                    // widegtSwitch1 = false;
                    // widegtSwitch2 = true;
                    // selectedPackageId = mainRound.round.packages[2].id;
                    // mainRound.round.selectedPackageId =
                    //     mainRound.round.packages[2].id;
                    // selectedPackageAccumulativePrice =
                    //     mainRound.round.packages[2].accumulativePrice;

                    if (mainRound.user.coins <
                        int.parse(
                            mainRound.round.packages[2].participationFee)) {
                      noEnoughCoinsWidget();
                    } else {
                      widegtSwitch0 = false;
                      widegtSwitch1 = false;
                      widegtSwitch2 = true;
                      selectedPackageId = mainRound.round.packages[2].id;
                      mainRound.round.selectedPackageId =
                          mainRound.round.packages[2].id;
                      selectedPackageAccumulativePrice =
                          mainRound.round.packages[2].accumulativePrice;
// updating User coins value live
                      globalUserCoinsValue = 0;
                      globalUserCoinsValue = mainRound.user.coins -
                          int.parse(
                              mainRound.round.packages[2].participationFee);
                    }
                  });
                },
                child: widegtSwitch2 == false
                    ? priceAmountSimpleWidget(mainRound.round.packages[2])
                    : priceAmountSelectedWidget(mainRound.round.packages[2]),
              ),

              //priceAmountSimpleWidget(mainRound.round.packages[1]),
              // priceAmountSimpleWidget(mainRound.round.packages[2]),
              // priceAmountSelectedWidget(mainRound.round.packages[2])
            ],
          ),
        ],
      ),
    );
  }

  Widget priceAmountSimpleWidget(Packages packages) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.background1,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                packages.participationFee != null
                    ? "Coins".tr().toString()+" : ${packages.participationFee}"
                    : "--",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: AppTheme.appDefaultColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w700)),
            SizedBox(
              height: 2,
            ),
            Text(
                packages.accumulativePrice != null
                    ? "Accumulate".tr().toString()+" Rs: ${packages.accumulativePrice}"
                    : "--",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.black45,
                    fontSize: 9,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget priceAmountSelectedWidget(Packages packages) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.appDefaultColor,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                packages.participationFee != null
                    ? "Coins".tr().toString()+" : ${packages.participationFee}"
                    : "--",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: AppTheme.nearlyWhite,
                    fontSize: 12,
                    fontWeight: FontWeight.w700)),
            SizedBox(
              height: 2,
            ),
            Text(
                packages.accumulativePrice != null
                    ? "Accumulate".tr().toString()+" Rs: ${packages.accumulativePrice}"
                    : "--",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.white70,
                    fontSize: 9,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget submitButton(MainRound mainRound, state) {
    if (mainRound.bid) {
      globalUserCoinsValue = 0;
    }
    // return mainRound.bid == false
    //     ?
    return state is MainRoundBetSubmitingInProgressState
        ? showReciptAndBetSubmittedButtons(mainRound)
        : SizedBox(
            height: MediaQuery.of(context).size.height * 0.047,
            width: MediaQuery.of(context).size.width * 0.95,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Container(
                // margin: EdgeInsets.only(top: 0.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  gradient: new LinearGradient(
                      colors: [AppTheme.appDefaultColor, AppTheme.appCardColor],
                      begin: const FractionalOffset(0.0, 1.0),
                      end: const FractionalOffset(0.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                    highlightColor: AppTheme.appDefaultButtonSplashColor,
                    splashColor: AppTheme.appDefaultButtonSplashColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 12.0),

//checking user before placing the order
                      // child: guestUserValue
                      //     ? Text("Sign In",
                      //         style: Theme.of(context).textTheme.bodyText2.copyWith(
                      //             fontWeight: FontWeight.w600, color: Colors.white))
                      //     : Text("Check out",
                      //         style: Theme.of(context).textTheme.bodyText2.copyWith(
                      //             fontWeight: FontWeight.w600, color: Colors.white)),

                      child: Text("Submit".tr().toString(),
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ),
                    onPressed: () async {
                      print("submit button pressed");

                      NetworkConnectivity.check().then((internet) {
                        if (internet) {
                          submitBetRequest(mainRound);
                        } else {
                          //show network erro

                          Methods.showToast(
                            context,
                            "Check your network".tr().toString(),
                          );
                          print("No internet ..............");
                        }
                      });
                    }),
              ),
            ),
          );
  }

  Widget showReciptAndBetSubmittedButtons(MainRound mainRound) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.047,
      width: MediaQuery.of(context).size.width * 0.95,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: Container(
          // margin: EdgeInsets.only(top: 0.0),
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            gradient: new LinearGradient(
                colors: [AppTheme.grey, AppTheme.grey],
                begin: const FractionalOffset(0.0, 1.0),
                end: const FractionalOffset(0.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: MaterialButton(
              highlightColor: AppTheme.appDefaultButtonSplashColor,
              splashColor: AppTheme.appDefaultButtonSplashColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2.0))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),

//checking user before placing the order
                // child: guestUserValue
                //     ? Text("Sign In",
                //         style: Theme.of(context).textTheme.bodyText2.copyWith(
                //             fontWeight: FontWeight.w600, color: Colors.white))
                //     : Text("Check out",
                //         style: Theme.of(context).textTheme.bodyText2.copyWith(
                //             fontWeight: FontWeight.w600, color: Colors.white)),

                child: Text("Please wait".tr().toString(),
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white)),
              ),
              onPressed: () async {
               

                // Methods.showToast(
                //     context, "You are already submitted the bet.");
              }),
        ),
      ),
    );
  }

  Widget noLiveRoundWidget(BuildContext context, String errorMessage) {
    return NoRoundLiveWidget(
      content: Text(
        "$errorMessage",
        style: Theme.of(context).textTheme.headline6,
      ),
      title: Text(""),
      firstColor: Colors.amber,
      secondColor: Colors.white,
      headerIcon: Icon(
        Icons.error_outline,
        size: 120.0,
        color: Colors.white,
      ),
    );
  }

  void noEnoughCoinsWidget() {
    showDialog(
        context: context,
        builder: (_) => NetworkGiffyDialog(
              // key: keys[1],
              image: Image.network(
                "https://cdn.dribbble.com/users/305550/screenshots/3764339/input_coin.gif",
                fit: BoxFit.cover,
              ),
              entryAnimation: EntryAnimation.TOP,
              title: Text(
                "You don't Have enough coins to join this Round !!!"
                    .tr()
                    .toString(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
              description: Text(
                "To buy coins please go to 'Buy' section from bottom bar"
                    .tr()
                    .toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
              ),
              onlyOkButton: true,
              onOkButtonPressed: () {
                Navigator.pop(context);
              },
            ));
  }
}
