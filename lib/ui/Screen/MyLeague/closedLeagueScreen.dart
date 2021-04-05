import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locteca/bloc/leaguesBloc/leaguesBloc.dart';
import 'package:locteca/bloc/leaguesBloc/leaguesEvent.dart';
import 'package:locteca/bloc/leaguesBloc/leaguesState.dart';
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/model/closedLeague.dart';
import 'package:locteca/ui/CommonWidget/circulerImageView.dart';
import 'package:locteca/ui/CommonWidget/loadingIndicator.dart';
import 'package:locteca/ui/Screen/GeneralRanking/generalRanking.dart';
import 'package:easy_localization/easy_localization.dart';

class ClosedLeagueScreenMain extends StatelessWidget {
  final int roundId;
  final String bettingDate;
  ClosedLeagueScreenMain({this.roundId, this.bettingDate});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) {
          return LeaguesBloc()
            ..add(GetClosedLeagueEvent(
                roundId: roundId, bettingDate: bettingDate));
        },
        child: ClosedLeagueScreen(
          roundId: roundId,
        ),
      ),
    );
  }
}

class ClosedLeagueScreen extends StatefulWidget {
  final int roundId;
  ClosedLeagueScreen({this.roundId});
  @override
  _ClosedLeagueScreenState createState() => _ClosedLeagueScreenState();
}

class _ClosedLeagueScreenState extends State<ClosedLeagueScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppTheme.background1,
      appBar: AppBar(
        //leading: Container(),
        iconTheme: IconThemeData(color: Colors.white38),
        centerTitle: true,
        backgroundColor: AppTheme.appDefaultColor,
        actions: [actionWidget(context)],
        title: Text(
          "Recent Closed League".tr().toString(),
          style: Theme.of(context).textTheme.button.copyWith(
              color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        elevation: 0,
      ),
      body: BlocListener<LeaguesBloc, LeaguesState>(
          listener: (BuildContext context, state) {
        if (state is LeaguesFailureState) {
          showMessageError(state.errorMessage);
        }

        print("Printing state from bloc lstener, and state is :  $state");
      }, child: BlocBuilder<LeaguesBloc, LeaguesState>(
        builder: (BuildContext context, state) {
          if (state is LeaguesFailureState) {
            return failedWidget(context);
          }
          if (state is ClosedLeaguesSuccessState) {
            return _buildBody(context, state.closedLeague);
          }
          if (state is LeaguesInProgressState) {
            return LoadingIndicator(Colors.indigo);
          }
          return Container();
        },
      )),
    );
  }

  Widget actionWidget(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              BlocProvider.of<LeaguesBloc>(context)
                  .add(GetClosedLeagueEvent(roundId: widget.roundId));
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
        BlocProvider.of<LeaguesBloc>(context)
            .add(GetClosedLeagueEvent(roundId: widget.roundId));
      },
    );
  }

  Widget _buildBody(BuildContext contex, ClosedLeague closedLeague) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Container(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: Column(
              children: [
                //CommonWidgets.mycustomDivider(context),
                _topWidget(context, closedLeague),
                SizedBox(
                  height: 10,
                ),
              ],
            )),
            closedLeague.firstPackageWinners == null &&
                    closedLeague.secondPackageWinners == null &&
                    closedLeague.thirdPackageWinners == null
                ? SliverToBoxAdapter()
                : SliverToBoxAdapter(
                    child: Container(
                    //color: AppTheme.background2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      // boxShadow: [
                      //   BoxShadow(color: Colors.green, spreadRadius: 3),
                      // ],
                    ),
                    height: MediaQuery.of(context).size.height * 0.325,
                    child: _tabWidget(context, closedLeague),
                  )),
            SliverToBoxAdapter(
                child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
              ],
            )),
            closedLeague.answers == null
                ? SliverToBoxAdapter()
                : SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        textDynamicWidget(context, "Round Answers"),
                        _resultWidget(contex, closedLeague.answers),
                      ],
                    ),
                  ),
            SliverToBoxAdapter(
                child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
              ],
            )),
            closedLeague.userAnswers == null
                ? SliverToBoxAdapter()
                : SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        textDynamicWidget(context, "User Answers"),
                        _resultWidget(contex, closedLeague.userAnswers),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget textDynamicWidget(BuildContext context, String text) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
          color: Colors.white
          //color: AppTheme.appDefaultColor2,
          ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 15,
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: AppTheme.appCardColor,
                    //color: AppTheme.appDefaultColor2,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      child: Text(
                        text.tr().toString(),
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                headingCard(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _topWidget(BuildContext context, ClosedLeague closedLeague) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white
          //color: AppTheme.appDefaultColor2,
          ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 15,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Icon(
                  Icons.gamepad,
                  size: 50,
                ),
                SizedBox(width: 8),
                Text(
                  closedLeague.round.name == null ||
                          closedLeague.round.name == ""
                      ? "N/A"
                      : closedLeague.round.name,
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(fontWeight: FontWeight.w900),
                ),
              ]),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      closedLeague.round.startingDate == null ||
                              closedLeague.round.startingDate == ""
                          ? "N/A"
                          : "Starting Date".tr().toString() +
                              " : " +
                              closedLeague.round.startingDate,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.black45, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      closedLeague.round.endingDate == null ||
                              closedLeague.round.endingDate == ""
                          ? "N/A"
                          : "Ending Date".tr().toString() +
                              " :   " +
                              closedLeague.round.endingDate,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.black45, fontWeight: FontWeight.w500),
                    ),
                  ])
            ],
          ),

          // Text(
          //   "Leader Board",
          //   style: Theme.of(context).textTheme.button.copyWith(fontSize: 18),
          // ),
        ]),
      ),
    );
  }

  Widget _tabWidget(BuildContext context, ClosedLeague closedLeague) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 15.0, top: 15, bottom: 10, right: 15),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppTheme.appDefaultColor2,
            ),
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: Text(
                  "Leader Board".tr().toString(),
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: TabBar(
            unselectedLabelColor: Colors.black38,
            isScrollable: true,
            labelColor: AppTheme.appCardColor,
            tabs: [
              Tab(
                text: '1st Package Winner'.tr().toString(),
              ),
              Tab(
                text: '2nd Package Winner'.tr().toString(),
              ),
              Tab(
                text: '3rd Package Winner'.tr().toString(),
              )
            ],
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
        Expanded(
          child: TabBarView(
            children: [
              closedLeague.firstPackageWinners == null
                  ? Center(
                      child: Text(
                      "No Winners".tr().toString(),
                    ))
                  : horizontalList(closedLeague.firstPackageWinners),
              closedLeague.secondPackageWinners == null
                  ? Center(
                      child: Text(
                      "No Winners".tr().toString(),
                    ))
                  : horizontalList(closedLeague.secondPackageWinners),
              closedLeague.thirdPackageWinners == null
                  ? Center(
                      child: Text(
                      "No Winners".tr().toString(),
                    ))
                  : horizontalList(closedLeague.thirdPackageWinners),
            ],
            controller: _tabController,
          ),
        ),
      ],
    );
  }

  Widget horizontalList(List<dynamic> package) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: package.length,
      itemBuilder: (BuildContext context, int index) =>
          winnerListItemCard(package[index]),
    );
  }

  Widget winnerListItemCard(dynamic package) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CirculerImageView(
            height: 60,
            width: 60,
            imageUrl: package.image == null || package.image == ""
                ? APIConstants.userImagePlaceHolder
                : package.image,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
              package.name == null || package.name == "" ? "N/A" : package.name,
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: AppTheme.appBackgroundColorforCard1,
                  fontSize: 12,
                  fontWeight: FontWeight.w900)),
          SizedBox(
            height: 10,
          ),
          creditWidget(context, Colors.amberAccent, package.winningCoins),
        ],
      ),
    );
  }

  Widget creditWidget(
      BuildContext context, Color backgroundColor, dynamic coins) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(FontAwesomeIcons.coins, size: 14, color: AppTheme.nearlyGold),
            SizedBox(
              width: 12,
            ),
            coins == null || coins == "N/A"
                ? Container()
                : Countup(
                    begin: 0,
                    end:
                        double.parse(coins) == null ? 0.0 : double.parse(coins),
                    duration: Duration(seconds: 3),
                    separator: ',',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: AppTheme.appDefaultColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w900)),
            // Text(coins == null ? "0" : "$coins",
            //     style: Theme.of(context).textTheme.bodyText2.copyWith(
            //         color: AppTheme.appDefaultColor,
            //         fontSize: 11,
            //         fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }

  Widget _resultWidget(BuildContext context, dynamic dynamicAnswers) {
    return SizedBox(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext contex, int index) {
          return dynamicAnswers.length != 0
              ? listWiewItemCard(contex, dynamicAnswers[index])
              : Center(
                  child: Text(
                    "No itmes".tr().toString(),
                  ),
                );
        },
        itemCount: dynamicAnswers.length == 0 ? 1 : dynamicAnswers.length,
      ),
    );
  }

  Widget headingCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.080,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
          Radius.circular(10),
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              creditWidgetTwo(
                  context,
                  10,
                  AppTheme.pieChartBackgroundColor1,
                  "Team A".tr().toString(),
                  15,
                  FontWeight.w900,
                  Colors.black54),

              creditWidgetTwo(
                  context,
                  10,
                  AppTheme.pieChartBackgroundColor1,
                  "Team B".tr().toString(),
                  15,
                  FontWeight.w900,
                  Colors.black54),
              creditWidgetTwo(
                  context,
                  10,
                  AppTheme.pieChartBackgroundColor1,
                  "Winner".tr().toString(),
                  15,
                  FontWeight.w900,
                  AppTheme.appDefaultColor),
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

  Widget creditWidgetTwo(
      BuildContext context,
      double cornerRadius,
      Color bgColor,
      String text,
      double fontSize,
      FontWeight fontWeight,
      Color textColor) {
    return Expanded(
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.070,
        decoration: BoxDecoration(
            // color: bgColor,
            // shape: BoxShape.circle,
            // borderRadius: BorderRadius.all(
            //   Radius.circular(cornerRadius),
            // )
            ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
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
      ),
    );
  }

  Widget listWiewItemCard(BuildContext context, dynamic answers) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              creditWidgetListCard(
                  context,
                  5,
                  AppTheme.background,
                  "${answers.teamA != null || answers.teamA != "" ? answers.teamA : "--"}",
                  10.0,
                  FontWeight.w600,
                  Colors.black54),
              SizedBox(
                width: 5,
              ),
              creditWidgetListCard(
                  context,
                  5,
                  AppTheme.background,
                  "${answers.teamB != null || answers.teamB != "" ? answers.teamB : "--"}",
                  10.0,
                  FontWeight.w600,
                  Colors.black54),
              SizedBox(
                width: 5,
              ),
              creditWidgetListCard(
                  context,
                  5,
                  AppTheme.background,
                  "${answers.winner != null || answers.winner != "" ? answers.winner : "--"}",
                  10.0,
                  FontWeight.w600,
                  Colors.cyan),
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

  Widget creditWidgetListCard(
      BuildContext context,
      double cornerRadius,
      Color bgColor,
      String text,
      double fontSize,
      FontWeight fontWeight,
      Color textColor) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.all(
              Radius.circular(cornerRadius),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3),
          child: Center(
            child: Text(text,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: fontWeight)),
          ),
        ),
      ),
    );
  }
}
