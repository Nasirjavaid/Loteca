import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/agentDashoardBloc/agentDashboardBloc.dart';
import 'package:locteca/bloc/agentDashoardBloc/agentDashboardEvent.dart';
import 'package:locteca/bloc/agentDashoardBloc/agentDashboardState.dart';
import 'package:locteca/bloc/userDashboardBloc/userDashboardBloc.dart';
import 'package:locteca/bloc/userDashboardBloc/userDashboardEvent.dart';
import 'package:locteca/bloc/userDashboardBloc/userDashboardState.dart';
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/config/methods.dart';
import 'package:locteca/config/networkConnectivity.dart';
import 'package:locteca/model/agentDashboardModel.dart';
import 'package:locteca/model/userDashboard.dart';
import 'package:locteca/ui/CommonWidget/commonWidgets.dart';
import 'package:locteca/ui/CommonWidget/roundedImageViewWithoutBorderDynamic.dart';
import 'package:locteca/ui/Screen/DashboardScreen/myNavDrawer.dart';
import 'package:locteca/ui/Screen/MakeBet/makeBet.dart';
import 'package:locteca/ui/Screen/SendCoinScreen/SendCoinScreen.dart';
import 'package:easy_localization/easy_localization.dart';

class UserDashboardScreenMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) {
          return UserDashboardBloc()..add(GetUserDashboardDataEvent());
        },
        child: UserDashboardScreen(),
      ),
    );
  }
}

class UserDashboardScreen extends StatefulWidget {
  @override
  _UserDashboardScreenState createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //  color: AppTheme.appDefaultColor,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [AppTheme.appDefaultColorForGradient, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: AppTheme.background1,
          appBar: AppBar(
              //leading: Container(),
              iconTheme: IconThemeData(color: Colors.white38),
              backgroundColor: AppTheme.appDefaultColor,
              elevation: 0,
              actions: [
                actionWidget(context),
              ]),
          // body: _buildBody(context),

          body: BlocListener<UserDashboardBloc, UserDashboardState>(
              listener: (BuildContext context, state) {
            print("Printing state from bloc lstener, and state is :  $state");
          }, child: BlocBuilder<UserDashboardBloc, UserDashboardState>(
            builder: (BuildContext context, state) {
              if (state is UserDashboardFailureState) {
                //return Center(child: failedWidget(context));
                return failedWidget(context);
              }
              if (state is UserDashboardSuccessState) {
                return _buildBody(context, state.userDashboard, state);
              }

              if (state is UserDashboardInProgressState) {
                UserDashboard userDashboard = UserDashboard();
                return Stack(
                  children: [
                    _buildBody(context, userDashboard, state),
                    CommonWidgets.progressIndicatorCustom
                  ],
                );
              }
              return Container(
                child: Center(child: CommonWidgets.progressIndicatorCustom),
              );
            },
          )),
          drawer: MyNaveDrawerMain(),
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
              BlocProvider.of<UserDashboardBloc>(context)
                  .add(GetUserDashboardDataEvent());
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
        BlocProvider.of<UserDashboardBloc>(context)
            .add(GetUserDashboardDataEvent());
      },
    );
  }

  Widget _buildBody(BuildContext context, UserDashboard userDashboard, state) {
    return Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: BoxDecoration(
            color: AppTheme.appDefaultColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
      ),
      innerBodyOfStack(context, userDashboard, state),
    ]);
  }

  Widget innerBodyOfStack(
      BuildContext context, UserDashboard userDashboard, state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.195,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppTheme.background2,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  )),
              child: Stack(children: [
                Positioned.fill(
                    child: Align(
                  alignment: Alignment(-0.8, -1.60),
                  child: Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: RoundedCornerImageViewWithoutBorderDynamic(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.16,
                      imageLink: state is UserDashboardInProgressState ||
                              userDashboard.data.user.images == null ||
                              userDashboard.data.user.images == ""
                          ? APIConstants.userImagePlaceHolder
                          : userDashboard.data.user.images,
                      cornerRadius: 10,
                      borderWidth: 1.0,
                    ),
                  ),
                )),
                Positioned.fill(
                    child: Align(
                  alignment: Alignment(-0.60, 0.43),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state is UserDashboardInProgressState ||
                                  userDashboard.data.user.name == null ||
                                  userDashboard.data.user.name == ""
                              ? "N/A"
                              : userDashboard.data.user.name,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Available Coins".tr().toString() + ":    ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(color: Colors.black87),
                            ),
                            Text(
                              state is UserDashboardInProgressState ||
                                      userDashboard.data.user.coinsAvailable ==
                                          null
                                  ? "0"
                                  : userDashboard.data.user.coinsAvailable
                                      .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(color: Colors.black, fontSize: 17),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Phone".tr().toString() +
                              ":      ${state is UserDashboardInProgressState || userDashboard.data.user.phone == null || userDashboard.data.user.phone == "" ? "N/A" : userDashboard.data.user.phone}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.black87),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "WhatsApp".tr().toString() +
                              ":      ${state is UserDashboardInProgressState || userDashboard.data.user.whatsapp == null || userDashboard.data.user.whatsapp == "" ? "N/A" : userDashboard.data.user.whatsapp}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.black87),
                        ),
                        // SizedBox(
                        //   height: 3,
                        // ),
                        // Text(
                        //   "Address:  Temple Road GT No. 59-BT-9",
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .bodyText2
                        //       .copyWith(color: Colors.black87),
                        // ),
                      ]),
                )),
              ]),
            ),
            SizedBox(
              height: 12,
            ),
            placeMyBet(
              context,
            ),
            SizedBox(
              height: 12,
            ),
            betRecordWidget(context, userDashboard, state),
            SizedBox(
              height: 12,
            ),
            pointsRecordWidget(context, userDashboard, state),
            SizedBox(
              height: 12,
            ),
            coinsRecordWidget(context, userDashboard, state),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget placeMyBet(BuildContext context) {
    return InkWell(
      onTap: () {
        NetworkConnectivity.check().then((internet) {
          if (internet) {
            Navigator.of(context)
                .push(
                  new MaterialPageRoute(builder: (_) => MakeBetMain(0)),
                )
                .then((val) => val
                    ? BlocProvider.of<UserDashboardBloc>(context)
                        .add(GetUserDashboardDataEvent())
                    : null);
          } else {
            //show network erro

            Methods.showToast(context, "Check your network".tr().toString());
          }
        });
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.062,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: AppTheme.background2,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            )),
        child: Center(
            child: Text(
          "Make Bet".tr().toString(),
          style: Theme.of(context).textTheme.bodyText2.copyWith(
              color: AppTheme.appCardColor,
              fontSize: 16,
              fontWeight: FontWeight.w900),
        )),
      ),
    );
  }

  Widget betRecordWidget(
      BuildContext context, UserDashboard userDashboard, state) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.32,
      decoration: BoxDecoration(
          color: AppTheme.background2,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              saleInnerCard(context, "Total ActiveBets Placed".tr().toString(),
                  "${state is UserDashboardInProgressState || userDashboard.data.totalActiveBetsPlaced == null || userDashboard.data.totalActiveBetsPlaced == "" ? "N/A" : userDashboard.data.totalActiveBetsPlaced}"),
              saleInnerCard(context, "Total Closed Bets Placed".tr().toString(),
                  "${state is UserDashboardInProgressState || userDashboard.data.totalClosedBetsPlaced == null || userDashboard.data.totalClosedBetsPlaced == "" ? "N/A" : userDashboard.data.totalClosedBetsPlaced}"),
              saleInnerCard(context, "Total Bets Placed".tr().toString(),
                  "${state is UserDashboardInProgressState || userDashboard.data.totalBetsPlaced == null || userDashboard.data.totalBetsPlaced == "" ? "N/A" : userDashboard.data.totalBetsPlaced}"),
            ]),
      ),
    );
  }

  Widget pointsRecordWidget(
      BuildContext context, UserDashboard userDashboard, state) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: BoxDecoration(
          color: AppTheme.background3,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          totalSaleInnerCard(context, "Points Earned".tr().toString(),
              "${state is UserDashboardInProgressState || userDashboard.data.pointsEarned == null || userDashboard.data.pointsEarned == "" ? "N/A" : userDashboard.data.pointsEarned}"),
          totalSaleInnerCard(context, "Points Betted For".tr().toString(),
              "${state is UserDashboardInProgressState || userDashboard.data.totalPointsBettedFor == null || userDashboard.data.totalPointsBettedFor == "" ? "N/A" : userDashboard.data.totalPointsBettedFor}"),
        ]),
      ),
    );
  }

  Widget coinsRecordWidget(
      BuildContext context, UserDashboard userDashboard, state) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.11,
      decoration: BoxDecoration(
          color: AppTheme.background2,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          withdawInnerCardWidget(context, "Total Coins Won".tr().toString(),
              "${state is UserDashboardInProgressState || userDashboard.data.totalCoinsWon == null || userDashboard.data.totalCoinsWon == null ? "N/A" : userDashboard.data.totalCoinsWon}"),
        ]),
      ),
    );
  }

  Widget saleInnerCard(
      BuildContext context, String heading, String subHeading) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.78,
      height: MediaQuery.of(context).size.height * 0.09,
      decoration: BoxDecoration(
          color: AppTheme.background3,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          )),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(
            heading,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.black87, fontWeight: FontWeight.w900),
          ),
          // SizedBox(
          //   height: 18,
          // ),
          Text(
            subHeading,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: AppTheme.appDefaultColor,
                fontSize: 15,
                fontWeight: FontWeight.w900),
          ),
        ]),
      ),
    );
  }

  Widget withdawInnerCardWidget(
      BuildContext context, String heading, String subHeading) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.78,
      height: MediaQuery.of(context).size.height * 0.09,
      decoration: BoxDecoration(
          color: AppTheme.background3,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(
            heading,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Colors.black87, fontWeight: FontWeight.w900),
          ),
          // SizedBox(
          //   height: 18,
          // ),
          Text(
            subHeading,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: AppTheme.appDefaultColor,
                fontSize: 17,
                fontWeight: FontWeight.w900),
          ),
        ]),
      ),
    );
  }

  Widget totalSaleInnerCard(
      BuildContext context, String heading, String subHeading) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.38,
      height: MediaQuery.of(context).size.height * 0.09,
      decoration: BoxDecoration(
          color: AppTheme.background2,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(
            heading,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: Colors.black87,
                fontSize: 13,
                fontWeight: FontWeight.w900),
          ),
          // SizedBox(
          //   height: 18,
          // ),
          Text(
            subHeading,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: AppTheme.appDefaultColor,
                fontSize: 16,
                fontWeight: FontWeight.w900),
          ),
        ]),
      ),
    );
  }
}
