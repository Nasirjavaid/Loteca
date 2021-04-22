import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/leaderBoardBloc/leaderBoardBloc.dart';
import 'package:locteca/bloc/leaderBoardBloc/leaderBoardEvent.dart';
import 'package:locteca/bloc/leaderBoardBloc/leaderBoardState.dart';
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/model/leaderBoard.dart';
import 'package:locteca/ui/CommonWidget/circulerImageView.dart';
import 'package:locteca/ui/CommonWidget/loadingIndicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:locteca/ui/Screen/DashboardScreen/myNavDrawer.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

class GeneralRankingMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) {
          return LeaderBoardBloc()..add(GetLeaderBoardListEvent());
        },
        child: GeneralRanking(),
      ),
    );
  }
}

class GeneralRanking extends StatefulWidget {
  @override
  _GeneralRankingState createState() => _GeneralRankingState();
}

class _GeneralRankingState extends State<GeneralRanking> {
  Widget _buildBodyForThisMonth(
      BuildContext context, List<LeaderBoardMonthly> leaderBoardMonthly) {
    List<LeaderBoardMonthly> leaderBoardMonthlyTopThree =
        List<LeaderBoardMonthly>();
    if (leaderBoardMonthly.length > 3) {
      for (int i = 0; i < 3; i++) {
        leaderBoardMonthlyTopThree.add(leaderBoardMonthly[i]);
        //leaderBoardMonthly.remove(leaderBoardMonthly[i]);
      }
    }

    return CustomScrollView(
      slivers: [
        // SliverAppBar(
        //  // pinned: true,
        //   leading: Container(),
        //   toolbarHeight: MediaQuery.of(context).size.height * 0.135,
        //   flexibleSpace: horizontalCalender(context),
        // ),

        SliverToBoxAdapter(
          child: leaderBoardMonthly.length > 3
              ? postionedBaseUserCards(leaderBoardMonthlyTopThree)
              : listofTeams(context, leaderBoardMonthly),
        ),

        SliverToBoxAdapter(
            child:
                //CommonWidgets.mycustomDivider(context),
                leaderBoardMonthly.length > 3
                    ? listofTeams(context, leaderBoardMonthly)
                    : Container()),
        // listofTeams(context, leaderBoardMonthly)
      ],
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
        BlocProvider.of<LeaderBoardBloc>(context)
            .add(GetLeaderBoardListEvent());
      },
    );
  }

  Widget postionedBaseUserCards(List<LeaderBoardMonthly> leaderBoardMonthly) {
    return Container(
        child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(
                Radius.circular(0),
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_alert,
                  size: 15,
                  color: Colors.redAccent,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Each correct answer will give you 1 point(s) for Leaderboard."
                      .tr()
                      .toString(),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black54, fontSize: 11),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              children: [
                Avatar(
                  circleTextWidget: ScaleAnimatedTextKit(
                    repeatForever: true,
                    duration: const Duration(milliseconds: 1000),
                    onTap: () {
                      print("Tap Event");
                    },
                    text: ["2"],
                    textStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                    // textStyle: TextStyle(fontSize: 14.0, fontFamily: "Canterbury"),
                    textAlign: TextAlign.start,
                  ),
                  circleShow: true,
                  circleColor: Colors.blueGrey,
                  circleHeight: 20,
                  circleWidth: 20,
                  height: 65,
                  width: 65,
                  imageUrl: leaderBoardMonthly[1].image == null ||
                          leaderBoardMonthly[1].image == ""
                      ? APIConstants.userImagePlaceHolder
                      : leaderBoardMonthly[1].image,
                  radius: 40,
                  backgroundColor: Colors.white,
                  borderColor: Colors.grey.shade300,
                  borderWidth: 4.0,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                    leaderBoardMonthly[1].name == null ||
                            leaderBoardMonthly[1].name == ""
                        ? "N/A"
                        : leaderBoardMonthly[1].name,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: AppTheme.appBackgroundColorforCard1,
                        fontSize: 12,
                        fontWeight: FontWeight.w900)),
                SizedBox(
                  height: 10,
                ),
                creditWidget(context, Colors.amberAccent,
                    leaderBoardMonthly[1].winningCoins),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 6,
                ),
                Avatar(
                  circleTextWidget: ScaleAnimatedTextKit(
                    repeatForever: true,
                    duration: const Duration(milliseconds: 1000),
                    onTap: () {
                      print("Tap Event");
                    },
                    text: ["1"],
                    textStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                    // textStyle: TextStyle(fontSize: 14.0, fontFamily: "Canterbury"),
                    textAlign: TextAlign.start,
                  ),
                  circleShow: true,
                  circleColor: Colors.green,
                  circleHeight: 30,
                  circleWidth: 30,
                  height: 100,
                  width: 100,
                  imageUrl: leaderBoardMonthly[0].image == null ||
                          leaderBoardMonthly[0].image == ""
                      ? APIConstants.userImagePlaceHolder
                      : leaderBoardMonthly[0].image,
                  radius: 40,
                  backgroundColor: Colors.white,
                  borderColor: Colors.grey.shade300,
                  borderWidth: 4.0,
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                    leaderBoardMonthly[0].name == null ||
                            leaderBoardMonthly[0].name == ""
                        ? "N/A"
                        : leaderBoardMonthly[0].name,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: AppTheme.appBackgroundColorforCard1,
                        fontSize: 16,
                        fontWeight: FontWeight.w900)),
                SizedBox(
                  height: 8,
                ),
                creditWidget(context, Colors.blueGrey[100],
                    leaderBoardMonthly[0].winningCoins),
                SizedBox(
                  height: 0,
                )
              ],
            ),
            Column(
              children: [
                Avatar(
                  circleTextWidget: ScaleAnimatedTextKit(
                    repeatForever: true,
                    duration: const Duration(milliseconds: 1000),
                    onTap: () {
                      print("Tap Event");
                    },
                    text: ["3"],
                    textStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                    // textStyle: TextStyle(fontSize: 14.0, fontFamily: "Canterbury"),
                    textAlign: TextAlign.start,
                  ),
                  circleShow: true,
                  circleColor: Colors.cyan,
                  circleHeight: 20,
                  circleWidth: 20,
                  height: 65,
                  width: 65,
                  imageUrl: leaderBoardMonthly[2].image == null ||
                          leaderBoardMonthly[2].image == ""
                      ? APIConstants.userImagePlaceHolder
                      : leaderBoardMonthly[2].image,
                  radius: 40,
                  backgroundColor: Colors.white,
                  borderColor: Colors.grey.shade300,
                  borderWidth: 4.0,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                    leaderBoardMonthly[2].name == null ||
                            leaderBoardMonthly[2].name == ""
                        ? "N/A"
                        : leaderBoardMonthly[2].name,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: AppTheme.appBackgroundColorforCard1,
                        fontSize: 12,
                        fontWeight: FontWeight.w900)),
                SizedBox(
                  height: 8,
                ),
                creditWidget(context, AppTheme.background3,
                    leaderBoardMonthly[2].winningCoins),
              ],
            ),
          ],
        ),
      ],
    ));
  }

  Widget creditWidget(BuildContext context, Color backgroundColor, int coins) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 22),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  color: AppTheme.nearlyGold,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  )),
            ),
            SizedBox(
              width: 12,
            ),
            Countup(
                begin: 0,
                end: coins.toDouble() == null ? 0.0 : coins.toDouble(),
                duration: Duration(seconds: 3),
                separator: ',',
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: AppTheme.appDefaultColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w900)),

            // Text(coins == null ? "0" : "$coins",
            //     style: Theme.of(context).textTheme.bodyText2.copyWith(
            //         color: AppTheme.appDefaultColor,
            //         fontSize: 12,
            //         fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }

  Widget creditWidgetForListItemCard(
      BuildContext context, Color backgroundColor, var coins) {
    return Container(
      width: MediaQuery.of(context).size.width*0.20,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Icon(FontAwesomeIcons.circle, size: 12, color: Colors.black38),
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  )),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
                          child: Text(coins == null || coins == "" ? "N/A" : "$coins",textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: AppTheme.appDefaultColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w900)),
            ),
          ],
        ),
      ),
    );
  }

  Widget listofTeams(BuildContext context, List leaderBoardGenericList) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        width: MediaQuery.of(context).size.width * 0.95,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            )),
       
          child: ListView.builder(
              padding: EdgeInsets.only(top:2,bottom: 100),
              itemCount: leaderBoardGenericList.length == 0
                  ? 1
                  : leaderBoardGenericList.length,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return leaderBoardGenericList.length == 0
                    ? Center(
                        child: Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              "No Items".tr().toString(),
                            )))
                    : listWiewItemCard(
                        context, index, leaderBoardGenericList[index]);
              }),
        
      ),
    );
  }

  Widget listWiewItemCard(
      BuildContext context, int index, var leaderBordGenericItem) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    //borderRadius: BorderRadius.all(Radius.circular(25)),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: Colors.black45, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Avatar(
                  circleShow: false,
                  height: 45,
                  width: 45,
                  imageUrl: leaderBordGenericItem.image == null ||
                          leaderBordGenericItem.image == ""
                      ? APIConstants.userImagePlaceHolder
                      : leaderBordGenericItem.image,
                  radius: 40,
                  backgroundColor: Colors.white,
                  borderColor: Colors.grey.shade300,
                  borderWidth: 4.0,
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      leaderBordGenericItem.name == null ||
                              leaderBordGenericItem.name == ""
                          ? "N/A"
                          : leaderBordGenericItem.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: Colors.black87, fontSize: 12.5),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    // Text(
                    //   leaderBordGenericItem.winningCoins == null ||
                    //           leaderBordGenericItem.winningCoins == ""
                    //       ? "N/A"
                    //       : "Total Coins".tr().toString() +
                    //           " : ${leaderBordGenericItem.coins}",
                    //   style: Theme.of(context)
                    //       .textTheme
                    //       .bodyText1
                    //       .copyWith(color: Colors.black38, fontSize: 10),
                    // ),
                  ],
                ),
              ],
            ),
            creditWidgetForListItemCard(context, AppTheme.background3,
                leaderBordGenericItem.winningCoins),
          ],
        ),
      ),
    );
  }

  Widget actionWidget(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              BlocProvider.of<LeaderBoardBloc>(context)
                  .add(GetLeaderBoardListEvent());
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white38),

          elevation: 0.0,
          actions: [
            actionWidget(context),
          ],
          // toolbarHeight: 50,
          centerTitle: true,
          // backgroundColor: AppTheme.appDefaultColor,

          title: Text(
            "Ranking".tr().toString(),
            style: Theme.of(context).textTheme.button.copyWith(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),

          backgroundColor: AppTheme.appDefaultColor,
          bottom: TabBar(
            tabs: [
              Tab(
                  icon: Text(
                "Monthly".tr().toString(),
                style: Theme.of(context).textTheme.button.copyWith(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
              )),
              Tab(
                  icon: Text(
                "All Time".tr().toString(),
                style: Theme.of(context).textTheme.button.copyWith(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
              )),
            ],
          ),
        ),
        body: BlocListener<LeaderBoardBloc, LeaderBoardState>(
            listener: (BuildContext context, state) {
          print("Printing state from bloc lstener, and state is :  $state");
        }, child: BlocBuilder<LeaderBoardBloc, LeaderBoardState>(
          builder: (BuildContext context, state) {
            if (state is LeaderBoardFailureState) {
              return Center(child: failedWidget(context));
            }
            if (state is LeaderBoardSuccessState) {
              return TabBarView(
                children: [
                  _buildBodyForThisMonth(
                      context, state.leaderBoardModel.leaderBoardMonthly),
                  listofTeams(
                      context, state.leaderBoardModel.leaderBoardAllTime),
                ],
              );
            }
            if (state is LeaderBoardInProgressState) {
              return LoadingIndicator(Colors.indigo);
            }
            return Container();
          },
        )),

        drawer: MyNaveDrawerMain(),
      ),
    ));
  }
}

class Avatar extends StatelessWidget {
  const Avatar({
    Key key,
    this.height,
    this.width,
    @required this.imageUrl,
    this.borderColor = Colors.grey,
    this.backgroundColor,
    this.radius = 30,
    this.borderWidth = 5,
    this.circleColor,
    this.circleHeight,
    this.circleWidth,
    this.circleShow,
    this.circleTextWidget,
  }) : super(key: key);

  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final Color circleColor;
  final double circleHeight;
  final bool circleShow;
  final double circleWidth;
  final String imageUrl;
  final double radius;
  final double height, width;
  final Widget circleTextWidget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CirculerImageView(
          height: height,
          width: width,
          imageUrl: imageUrl,
        ),
        circleShow
            ? Positioned.fill(
                child: Align(
                  alignment: Alignment(0, 1.5),
                  child: Container(
                    width: circleWidth,
                    height: circleHeight,
                    decoration: BoxDecoration(
                      color: circleColor,
                      border: Border.all(color: Colors.white),
                      //borderRadius: BorderRadius.all(Radius.circular(25)),
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: circleTextWidget),
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
