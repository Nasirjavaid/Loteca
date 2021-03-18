import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/lastRoundResultBloc/lastRoundResultBloc.dart';
import 'package:locteca/bloc/lastRoundResultBloc/lastRoundResultEvent.dart';
import 'package:locteca/bloc/lastRoundResultBloc/lastRoundResultState.dart';

import 'package:locteca/config/appTheme.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:locteca/model/lastRoundResult.dart';
import 'package:locteca/ui/CommonWidget/loadingIndicator.dart';
import 'package:locteca/ui/Screen/DashboardScreen/myNavDrawer.dart';

class ResultMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) {
          return LastRoundResulBloc()..add(GetLastRoundResultEvent());
        },
        child: Result(),
      ),
    );
  }
}

class Result extends StatefulWidget {
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
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white38),

        elevation: 0.0,
        actions: [
        actionWidget(context)
        ],
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
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 3),
          // child: listofTeams(context),
          child: Column(
            children: [
              // SizedBox(
              //   height: 12,
              // ),
              // creditWidget(context, 10,Colors.blue[100], "Recent Closed Round", 24,
              //     FontWeight.w900),
              // SizedBox(
              //   height: 12,
              // ),
              Flexible(
                flex: 2,
                child: headingCard(context),
              ),
              Flexible(
                flex: 15,
                child: listofTeams(context,state.lastRoundResult.answers),
              )
            ],
          ),
        );
      }

      return Container();
    }));

    // return Container(
    //   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 3),
    //   // child: listofTeams(context),
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
    //         child: listofTeams(context),
    //       )
    //     ],
    //   ),
    // );
  }

  Widget listofTeams(BuildContext context,List<Answers> answers) {
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
            itemCount: answers.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return listWiewItemCard(context,answers[index]);
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
        BlocProvider.of<LastRoundResulBloc>(context).add(GetLastRoundResultEvent());
      },
    );
  }

  Widget listWiewItemCard(BuildContext context,Answers answers) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.6),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              creditWidget(context, 10, AppTheme.background, "${answers.teamA != null || answers.teamA !="" ?  answers.teamA :"--"}", 10,
                  FontWeight.w500, Colors.black54),
                  SizedBox(width: 5,),
              creditWidget(context, 10, AppTheme.background,  "${answers.teamB != null || answers.teamB !="" ?  answers.teamB :"--"}", 10,
                  FontWeight.w500, Colors.black54),
                   SizedBox(width: 5,),
              creditWidget(context, 10, AppTheme.background, "${answers.winner != null || answers.winner !="" ?  answers.winner :"--"}", 10,
                  FontWeight.w700, Colors.cyan),
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
               maxLines: 2,overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: textColor,
                        fontSize: fontSize,
                        fontWeight: fontWeight)),
             ),
            
          
        ),
      ),
    );
  }

  Widget creditWidgetTwo(
      BuildContext context,
      double cornerRadius,
      Color bgColor,
      String text,
      double fontSize,
      FontWeight fontWeight,
      Color textColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.070,
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
}
