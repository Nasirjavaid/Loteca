import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/lastRoundResultBloc/lastRoundResultBloc.dart';
import 'package:locteca/bloc/lastRoundResultBloc/lastRoundResultEvent.dart';
import 'package:locteca/bloc/lastRoundResultBloc/lastRoundResultState.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:locteca/ui/CommonWidget/loadingIndicator.dart';
import 'package:locteca/ui/Screen/DashboardScreen/myNavDrawer.dart';
import 'package:locteca/ui/Screen/Result/roundDetailScreen.dart';

import '../../../model/lastRoundResult.dart';
import '../../CommonWidget/circulerStaticImageView.dart';
import '../Buy/agentNavDrawer.dart';

class ResultMain extends StatelessWidget {
  final int agentOrUserSideCall;
  ResultMain(this.agentOrUserSideCall);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) {
          return LastRoundResulBloc()..add(GetLastRoundResultEvent());
        },
        child: Result(agentOrUserSideCall: agentOrUserSideCall),
      ),
    );
  }
}

class Result extends StatefulWidget {
  final int agentOrUserSideCall;
  Result({this.agentOrUserSideCall});
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Widget actionWidget(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              BlocProvider.of<LastRoundResulBloc>(context)
                  .add(GetLastRoundResultEvent());
            }));
  }

  @override
  Widget build(BuildContext context) {
    return widget.agentOrUserSideCall == 1
        ? userSideScaffold(context)
        : agentSideScaffold(context);
  }

  Widget agentSideScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white38),

        elevation: 0.0,
        actions: [actionWidget(context)],
        // toolbarHeight: 50,
        centerTitle: true,
        backgroundColor: AppTheme.appDefaultColor,

        title: Text(
          "Recent Closed Round".tr().toString(),
          style: Theme.of(context).textTheme.button.copyWith(
              color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: _buildBody(context),
     
    );
  }

  Widget userSideScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white38),

        elevation: 0.0,
        actions: [actionWidget(context)],
        // toolbarHeight: 50,
        centerTitle: true,
        backgroundColor: AppTheme.appDefaultColor,

        title: Text(
          "Recent Closed Round".tr().toString(),
          style: Theme.of(context).textTheme.button.copyWith(
              color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: _buildBody(context),
      drawer: MyNaveDrawerMain(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocListener<LastRoundResulBloc, LastRoundResultState>(
        listener: (context, state) {
      if (state is LastRoundResultFailureState) {
        // showMessageError("${state.errorMessage}");

        print("Error : ${state.errorMessage}");
      }
    }, child: BlocBuilder<LastRoundResulBloc, LastRoundResultState>(
            builder: (context, state) {
      if (state is LastRoundResultFailureState) {
        return failedWidget(context);
      }
      if (state is LastRoundResultInProgressState) {
        return LoadingIndicator(Colors.amber);
      }
      if (state is LastRoundResultSuccessState) {
        return Container(
          child: listOfRounds(context, state.lastRoundResult),
        );
      }

      return Container();
    }));

    // return Container(
    //   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 3),
    //   // child: listOfRounds(context),
    //   child: Column(
    //     children: [
    //       // SizedBox(
    //       //   height: 12,
    //       // ),
    //       // creditWidget(context, 10,Colors.blue[100], "Recent Closed Round", 24,
    //       //     FontWeight.w900),
    //       // SizedBox(
    //       //   height: 12,
    //       // ),
    //       Flexible(
    //         flex: 2,
    //         child: headingCard(context),
    //       ),
    //       Flexible(

    //         flex: 15,
    //         child: listOfRounds(context),
    //       )
    //     ],
    //   ),
    // );
  }

  Widget listOfRounds(BuildContext context, LastRoundResult lastRoudsResults) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.73,
      decoration: BoxDecoration(
          // color: AppTheme.appCardColor,
          borderRadius: BorderRadius.all(
        Radius.circular(15),
      )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 3),
        child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: lastRoudsResults.lastClosedRounds.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return listWiewItemCard(
                  context, lastRoudsResults.lastClosedRounds[index]);
            }),
      ),
    );
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
        BlocProvider.of<LastRoundResulBloc>(context)
            .add(GetLastRoundResultEvent());
      },
    );
  }

  Widget listWiewItemCard(
      BuildContext context, LastClosedRounds lastClosedRounds) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.6),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RoundDetailScreenMain(
                        roundName: lastClosedRounds.name,
                        roundId: lastClosedRounds.id,
                      )),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 10,
            decoration: BoxDecoration(
                color: AppTheme.background2,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                )),
            margin: EdgeInsets.symmetric(vertical: 1, horizontal: 6),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: CirculerStaticImageView(
                          height: 60,
                          width: 60,
                          imageUrl: 'assets/images/icon.png')),
                  SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              lastClosedRounds.name == null ||
                                      lastClosedRounds.name == ""
                                  ? "N/A"
                                  : lastClosedRounds.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12.5),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Starting Date".tr().toString(),
                              textAlign: TextAlign.end,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: Colors.black38, fontSize: 10),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  //color: Colors.blue[100],
                                  borderRadius: BorderRadius.all(
                                Radius.circular(2),
                              )),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 1.0, horizontal: 8),
                                child: Text(
                                  "${lastClosedRounds.startingDate == null || lastClosedRounds.startingDate == "" ? "N/A" : lastClosedRounds.startingDate}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: Colors.blue[900],
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Ending Date".tr().toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: Colors.black38, fontSize: 10),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  // color: Colors.red[100],
                                  borderRadius: BorderRadius.all(
                                Radius.circular(2),
                              )),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 1.0, horizontal: 8),
                                child: Text(
                                  "${lastClosedRounds.endingDate == null || lastClosedRounds.endingDate == "" ? "N/A" : lastClosedRounds.endingDate} ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: Colors.red[900],
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

Widget headingCard(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 0.6),
    child: Container(
      // height: MediaQuery.of(context).size.height * 0.080,
      decoration: BoxDecoration(
          // color: Colors.blue[100],
          borderRadius: BorderRadius.all(
        Radius.circular(3),
      )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            creditWidgetTwo(context, 10, AppTheme.appDefaultColor,
                "Team A".tr().toString(), 11, FontWeight.w900, Colors.white),

            creditWidgetTwo(context, 10, AppTheme.appDefaultColor,
                "Team B".tr().toString(), 11, FontWeight.w900, Colors.white),
            creditWidgetTwo(context, 10, AppTheme.appDefaultColor,
                "Winner".tr().toString(), 11, FontWeight.w900, Colors.white),
            // Row(
            //   children: [
            //     Text(
            //       "Team Name",
            //       style: Theme.of(context)
            //           .textTheme
            //           .bodyText2
            //           .copyWith(color: Colors.white60),
            //     ),
            //     SizedBox(
            //       width: 4,
            //     ),
            //     Icon(
            //       Icons.flag,
            //       size: 25,
            //       color: Colors.white,
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    ),
  );
}

Widget creditWidget(BuildContext context, double cornerRadius, Color bgColor,
    String text, double fontSize, FontWeight fontWeight, Color textColor) {
  return Expanded(
    child: Container(
      height: 40,
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(
            Radius.circular(cornerRadius),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3),
        child: Center(
          child: Text(text,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight)),
        ),
      ),
    ),
  );
}

Widget creditWidgetTwo(BuildContext context, double cornerRadius, Color bgColor,
    String text, double fontSize, FontWeight fontWeight, Color textColor) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.080,
    decoration: BoxDecoration(
      color: bgColor,
      shape: BoxShape.circle,
      // borderRadius: BorderRadius.all(
      //   Radius.circular(cornerRadius),
      // )
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon(FontAwesomeIcons.coins, size: 20, color: AppTheme.nearlyGold),
          // SizedBox(
          //   width: 14,
          // ),
          Text(text,
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight)),
        ],
      ),
    ),
  );
}
