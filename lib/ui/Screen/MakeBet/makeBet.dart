import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/mainRoundBloc/mainRoundBloc.dart';
import 'package:locteca/bloc/mainRoundBloc/mainRoundEvent.dart';
import 'package:locteca/bloc/mainRoundBloc/mainRoundState.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locteca/config/networkConnectivity.dart';
import 'package:locteca/model/mainRound.dart';
import 'package:locteca/ui/CommonWidget/commonWidgets.dart';
import 'package:locteca/ui/CommonWidget/loadingIndicator.dart';
import 'package:locteca/ui/Screen/DashboardScreen/myNavDrawer.dart';

class MakeBetMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) {
          return MainRoundBloc()..add(GetMainRoundEvent());
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

  bool widegtSwitch0 = false;
  bool widegtSwitch1 = false;
  bool widegtSwitch2 = false;
  int selectedPackageId = 0;
  String selectedPackageAccumulativePrice;
     MainRound mainRoundGlobal;

  void showMessageError(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: color,
      content: new Text(
        message,
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      duration: const Duration(seconds: 5),
    ));
  }

  void submitBetRequest(MainRound mainRound) {
    if (mainRound.user.coins == 0 || mainRound.user.coins == null) {
      //show message with no coins error
      showMessageError("You dont have enough coins.");
      print("Request not Submitted... Dont have enough coins");
    } else if (selectedPackageId == null || selectedPackageId == 0) {
      // show error message to select a participation fee package
      print("Request not Submitted... did not selected the participation fee");
      showMessageError("Please select your bet fee");
    } else {
      bool checkPoint = true;
      for (int i = 0; i < mainRound.round.games.length; i++) {
        if (mainRound.round.games[i].widegtSwitch0 == false &&
            mainRound.round.games[i].widegtSwitch1 == false &&
            mainRound.round.games[i].widegtSwitch2 == false) {
          //show error to slect all the team winners/losser/or draw
          showMessageError(
              "Must select your choice from All team listed above");
          print(
              "Request not Submitted beacue team ${mainRound.round.games[i].name} is not selected");
          checkPoint = false;
          break;
        } else if (mainRound.round.games[i].widegtSwitch0 == null &&
            mainRound.round.games[i].widegtSwitch1 == null &&
            mainRound.round.games[i].widegtSwitch2 == null) {
          //show error to slect all the team winners/losser/or draw
          showMessageError(
              "Must select your choice from All team listed above");
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
            .add(SubmitBetButtonClickedEvent(mainRound: mainRound));
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
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white38),

            elevation: 0.0,
            actions: [
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.questionCircle,
                    color: Colors.white38,
                    size: 18,
                  ),
                  onPressed: null),
            ],
            // toolbarHeight: 50,
            centerTitle: true,
            // backgroundColor: AppTheme.appDefaultColor,
            backgroundColor: Colors.transparent,
            // title: Text(
            //   "Loteca",
            //   style:
            //       Theme.of(context).textTheme.button.copyWith(color: Colors.white),
            // ),
          ),
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



    return BlocListener<MainRoundBloc, MainRoundState>(
      
      listener:
        (context, state) {
      if (state is MainRoundFailureState) {
        showMessageError("${state.errorMessage}");

        print("Error : ${state.errorMessage}");
      }
    }, child:
        BlocBuilder<MainRoundBloc, MainRoundState>(builder: (context, state) {

        
      if (state is MainRoundSuccessState) {

        mainRoundGlobal = MainRound();
        mainRoundGlobal =state.mainRound;
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
              teamNameText(context, state.mainRound.round),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.024,
              ),
              listofTeams(context, state.mainRound),
              Spacer(),
              bottomCard(context, state.mainRound, state),
            ],
          ),
        );
      }

      if (state is MainRoundInProgressState) {
        return LoadingIndicator(Colors.white);
      }
      if (state is MainRoundFailureState) {
        return failedWidget(context);
      }

      if (state is MainRoundBetSubmitingInProgressState) {

       
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
              teamNameText(context, mainRoundGlobal.round),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.024,
              ),
              listofTeams(context, mainRoundGlobal),
              Spacer(),
              bottomCard(context,mainRoundGlobal, state),
            ],
          ),
        );
      }

      return Container(color: Colors.white);
    }));
  }

  Widget failedWidget(BuildContext context) {
    return FlatButton(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: Icon(Icons.refresh, size: 60, color: AppTheme.nearlyBlue),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Tap to reload",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white54),
            ),
          ],
        ),
      ),
      onPressed: () {
        BlocProvider.of<MainRoundBloc>(context).add(GetMainRoundEvent());
      },
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
            Text("LIVE",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: AppTheme.appDefaultColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w900)),
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

  Widget teamNameText(BuildContext context, Round round) {
    return Text(
      round.name == null || round.name == " " ? "---" : "${round.name}",
      style: Theme.of(context).textTheme.bodyText2.copyWith(
          color: Colors.white60, fontSize: 22, fontWeight: FontWeight.w900),
    );
  }

  Widget listofTeams(BuildContext context, MainRound mainRound) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
          color: AppTheme.appCardColor,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          )),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
            itemCount: mainRound.round.games.length,
            scrollDirection: Axis.vertical,
            //reverse: true,
            itemBuilder: (BuildContext context, int index) {
              // mainRound.round.games[index].widegtSwitch0 = false;
              // mainRound.round.games[index].widegtSwitch1 = false;
              // mainRound.round.games[index].widegtSwitch2 = false;
              return listWiewItemCard(context, mainRound, index);
            }),
      ),
    );
  }

  Widget listWiewItemCard(
      BuildContext context, MainRound mainRound, int index) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.5),
        child: Container(
            decoration: BoxDecoration(
                color: AppTheme.appDefaultColor2,
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                )),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, top: 10, bottom: 10, right: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            mainRound.round.games[index].widegtSwitch0 = true;
                            mainRound.round.games[index].widegtSwitch1 = false;
                            mainRound.round.games[index].widegtSwitch2 = false;
                          });
                          print(
                              "(Game id is ${mainRound.round.games[index].id}) and User selected Answer  => ${mainRound.round.games[index].userSelctedTeamOrAnswer = mainRound.round.games[index].teamA}");
                          print("TeamA clicked");
                        },
                        child: mainRound.round.games[index].widegtSwitch0 ==
                                    false ||
                                mainRound.round.games[index].widegtSwitch0 ==
                                    null
                            ? teamNameContainerNormal(
                                mainRound.round.games[index].teamA)
                            : selectedTeamNameContainer(
                                mainRound.round.games[index].teamA),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              mainRound.round.games[index].widegtSwitch0 =
                                  false;
                              mainRound.round.games[index].widegtSwitch1 = true;
                              mainRound.round.games[index].widegtSwitch2 =
                                  false;
                            });

                            print("Draw clicked");

                            print(
                                "(Game id is ${mainRound.round.games[index].id}) and User selected Answer => ${mainRound.round.games[index].userSelctedTeamOrAnswer = "Draw"}");
                          },
                          child: mainRound.round.games[index].widegtSwitch1 ==
                                      false ||
                                  mainRound.round.games[index].widegtSwitch1 ==
                                      null
                              ? teamMatchDrawContainerNormal()
                              : selectedTeamMatchDrawContainer()),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            mainRound.round.games[index].widegtSwitch0 = false;
                            mainRound.round.games[index].widegtSwitch1 = false;
                            mainRound.round.games[index].widegtSwitch2 = true;
                            print(
                                "(Game id is ${mainRound.round.games[index].id}) and User selected Answer => ${mainRound.round.games[index].userSelctedTeamOrAnswer = mainRound.round.games[index].teamB}");
                          });

                          print("TeamB clicked");
                        },
                        child: mainRound.round.games[index].widegtSwitch2 ==
                                    false ||
                                mainRound.round.games[index].widegtSwitch2 ==
                                    null
                            ? teamNameContainerNormal(
                                mainRound.round.games[index].teamB)
                            : selectedTeamNameContainer(
                                mainRound.round.games[index].teamB),
                      ),
                    ),
                  ]),
            )));
  }

  Widget teamNameContainerNormal(
    String teamName,
  ) {
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
                  Icon(
                    Icons.flag,
                    size: 18,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    teamName != null ? "$teamName" : "---",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Colors.white60, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget selectedTeamNameContainer(String teamName) {
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
                  Icon(
                    Icons.flag,
                    size: 18,
                    color: AppTheme.appDefaultColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    teamName != null ? "$teamName" : "---",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: AppTheme.appDefaultColor,
                        fontWeight: FontWeight.w800),
                  ),
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
      width: MediaQuery.of(context).size.width * 0.15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Draw",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.white60, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget selectedTeamMatchDrawContainer() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.15,
      decoration: BoxDecoration(
          color: AppTheme.background1,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.close_rounded,
                    size: 16,
                    color: AppTheme.lightRed,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Draw",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: AppTheme.appDefaultColor,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomCard(
      BuildContext context, MainRound mainRound, MainRoundState state) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.28,
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
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          creditWidget(context, mainRound),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
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
          state is MainRoundBetSubmitingInProgressState
              ? CommonWidgets.progressIndicator
              : submitButton(mainRound),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.010,
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
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 25),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(FontAwesomeIcons.coins, size: 20, color: AppTheme.nearlyGold),
            SizedBox(
              width: 14,
            ),
            Text(
                mainRound.user.coins != null ? "${mainRound.user.coins}" : "00",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: AppTheme.appDefaultColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w900)),
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
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Choose Amount ",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: AppTheme.appBackgroundColorforCard1,
                        fontSize: 16,
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
                    widegtSwitch0 = true;
                    widegtSwitch1 = false;
                    widegtSwitch2 = false;
                    selectedPackageId = mainRound.round.packages[0].id;
                    mainRound.round.selectedPackageId =
                        mainRound.round.packages[0].id;
                    selectedPackageAccumulativePrice =
                        mainRound.round.packages[0].accumulativePrice;
                  });
                },
                child: widegtSwitch0 == false
                    ? priceAmountSimpleWidget(mainRound.round.packages[0])
                    : priceAmountSelectedWidget(mainRound.round.packages[0]),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    widegtSwitch0 = false;
                    widegtSwitch1 = true;
                    widegtSwitch2 = false;
                    selectedPackageId = mainRound.round.packages[1].id;
                    mainRound.round.selectedPackageId =
                        mainRound.round.packages[1].id;
                    selectedPackageAccumulativePrice =
                        mainRound.round.packages[1].accumulativePrice;
                  });
                },
                child: widegtSwitch1 == false
                    ? priceAmountSimpleWidget(mainRound.round.packages[1])
                    : priceAmountSelectedWidget(mainRound.round.packages[1]),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    widegtSwitch0 = false;
                    widegtSwitch1 = false;
                    widegtSwitch2 = true;
                    selectedPackageId = mainRound.round.packages[2].id;
                    mainRound.round.selectedPackageId =
                        mainRound.round.packages[2].id;
                    selectedPackageAccumulativePrice =
                        mainRound.round.packages[2].accumulativePrice;
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
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                packages.participationFee != null
                    ? "Rs: ${packages.participationFee}"
                    : "--",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: AppTheme.appDefaultColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w700)),
            SizedBox(
              height: 2,
            ),
            Text(
                packages.accumulativePrice != null
                    ? "Accumulate Rs: ${packages.accumulativePrice}"
                    : "--",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.black26,
                    fontSize: 10,
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
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                packages.participationFee != null
                    ? "Rs: ${packages.participationFee}"
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
                    ? "Accumulate Rs: ${packages.accumulativePrice}"
                    : "--",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.white60,
                    fontSize: 10,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget submitButton(MainRound mainRound) {
  return  mainRound.bid == false ? SizedBox(
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

                child: Text("Submit",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white)),
              ),
              onPressed: () async {
                print("submit button pressed");

                NetworkConnectivity.check().then((internet) {
                  if (internet) {
                    submitBetRequest(mainRound);
                  } else {
                    //show network erro

                    // Methods.showToast(context, "Check your network");
                    print("No internet ..............");
                  }
                });
              }),
        ),
      ),
    ) :SizedBox(
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

                child: Text("You are already submitted the bet.",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white)),
              ),
              onPressed: () async {
                print("submit button pressed");

                // NetworkConnectivity.check().then((internet) {
                //   if (internet) {
                //     submitBetRequest(mainRound);
                //   } else {
                //     //show network erro

                //     // Methods.showToast(context, "Check your network");
                //     print("No internet ..............");
                //   }
                // });
              }),
        ),
      ),
    ) ;
  }
}
