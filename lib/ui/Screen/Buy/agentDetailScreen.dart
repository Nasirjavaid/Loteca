import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/agentDashoardBloc/agentDashboardBloc.dart';
import 'package:locteca/bloc/agentDashoardBloc/agentDashboardEvent.dart';
import 'package:locteca/bloc/agentDashoardBloc/agentDashboardState.dart';
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/config/methods.dart';
import 'package:locteca/config/networkConnectivity.dart';
import 'package:locteca/model/agentDashboardModel.dart';
import 'package:locteca/ui/CommonWidget/commonWidgets.dart';
import 'package:locteca/ui/CommonWidget/roundedImageViewWithoutBorderDynamic.dart';
import 'package:locteca/ui/Screen/Buy/agentNavDrawer.dart';
import 'package:locteca/ui/Screen/MakeBet/makeBet.dart';
import 'package:locteca/ui/Screen/SendCoinScreen/SendCoinScreen.dart';
import 'package:easy_localization/easy_localization.dart';

class AgentDetailScreenMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) {
          return AgentDashboardBloc()..add(GetAgentDashboardDataEvent());
        },
        child: AgentDetailScreen(),
      ),
    );
  }
}

class AgentDetailScreen extends StatefulWidget {
  @override
  _AgentDetailScreenState createState() => _AgentDetailScreenState();
}

class _AgentDetailScreenState extends State<AgentDetailScreen> {
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

          body: BlocListener<AgentDashboardBloc, AgentDashboardState>(
              listener: (BuildContext context, state) {
            print("Printing state from bloc lstener, and state is :  $state");
          }, child: BlocBuilder<AgentDashboardBloc, AgentDashboardState>(
            builder: (BuildContext context, state) {
              if (state is AgentDashboardFailureState) {
                //return Center(child: failedWidget(context));
                return failedWidget(context);
              }
              if (state is AgentDashboardSuccessState) {
                return _buildBody(context, state.agentDashboardModel, state);
              }

              if (state is AgentDashboardInProgressState) {
                AgentDashboardModel agentDashboardModel = AgentDashboardModel();
                return Stack(
                  children: [
                    _buildBody(context, agentDashboardModel, state),
                    CommonWidgets.progressIndicatorCustom
                  ],
                );
              }
              return Container();
            },
          )),
          drawer: AgentNavDrawerMain(),
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
              BlocProvider.of<AgentDashboardBloc>(context)
                  .add(GetAgentDashboardDataEvent());
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
        BlocProvider.of<AgentDashboardBloc>(context)
            .add(GetAgentDashboardDataEvent());
      },
    );
  }

  Widget _buildBody(
      BuildContext context, AgentDashboardModel agentDashboardModel, state) {
    return Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: BoxDecoration(
            color: AppTheme.appDefaultColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
      ),
      innerBodyOfStack(context, agentDashboardModel, state),
    ]);
  }

  Widget innerBodyOfStack(
      BuildContext context, AgentDashboardModel agentDashboardModel, state) {
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
                      imageLink: state is AgentDashboardInProgressState ||
                              agentDashboardModel.data.user.images[0].url ==
                                  null ||
                              agentDashboardModel.data.user.images[0].url == ""
                          ? APIConstants.userImagePlaceHolder
                          : agentDashboardModel.data.user.images[0].url,
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
                          state is AgentDashboardInProgressState ||
                                  agentDashboardModel.data.user.name == null ||
                                  agentDashboardModel.data.user.name == ""
                              ? "N/A"
                              : agentDashboardModel.data.user.name,
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
                              state is AgentDashboardInProgressState ||
                                      agentDashboardModel.data.user.coins ==
                                          null
                                  ? "0"
                                  : agentDashboardModel.data.user.coins
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
                              ":      ${state is AgentDashboardInProgressState || agentDashboardModel.data.user.contacts[0].phone == null || agentDashboardModel.data.user.contacts[0].phone == "" ? "N/A" : agentDashboardModel.data.user.contacts[0].phone}",
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
                              ":      ${state is AgentDashboardInProgressState || agentDashboardModel.data.user.contacts[0].whatsapp == null || agentDashboardModel.data.user.contacts[0].whatsapp == "" ? "N/A" : agentDashboardModel.data.user.contacts[0].whatsapp}",
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
            sendCoinsButton(
              context,
            ),
            SizedBox(
              height: 12,
            ),
            perDayAndWeeklySaleWidget(context, agentDashboardModel, state),
            SizedBox(
              height: 12,
            ),
            totalSaleAndCommissionWidget(context, agentDashboardModel, state),
            SizedBox(
              height: 12,
            ),
            availableForWithdrawWidget(context, agentDashboardModel, state),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget sendCoinsButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(
                  new MaterialPageRoute(builder: (_) => MakeBetMain(1)),
                )
                .then((val) => val
                    ? BlocProvider.of<AgentDashboardBloc>(context)
                        .add(GetAgentDashboardDataEvent())
                    : null);
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.062,
            width: MediaQuery.of(context).size.width * 0.35,
            decoration: BoxDecoration(
                color: AppTheme.background2,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                )),
            child: Center(
                child: Text(
              "Make Bet for others".tr().toString(),
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: AppTheme.appCardColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w900),
            )),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(
                  new MaterialPageRoute(builder: (_) => MakeBetMain(0)),
                )
                .then((val) => val
                    ? BlocProvider.of<AgentDashboardBloc>(context)
                        .add(GetAgentDashboardDataEvent())
                    : null);
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.062,
            width: MediaQuery.of(context).size.width * 0.35,
            decoration: BoxDecoration(
                color: AppTheme.background2,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                )),
            child: Center(
                child: Text(
              "Make My Bet".tr().toString(),
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: AppTheme.appCardColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w900),
            )),
          ),
        ),
      ],
    );
  }

  Widget perDayAndWeeklySaleWidget(
      BuildContext context, AgentDashboardModel agentDashboardModel, state) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.31,
      decoration: BoxDecoration(
          color: AppTheme.background2,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                saleInnerCard(context, "Today Sale".tr().toString(),
                    "${state is AgentDashboardInProgressState || agentDashboardModel.data.dailyData.sales == null || agentDashboardModel.data.dailyData.sales == "" ? "N/A" : agentDashboardModel.data.dailyData.sales}"),
                saleInnerCard(context, "Today Commission".tr().toString(),
                    "${state is AgentDashboardInProgressState || agentDashboardModel.data.dailyData.comission == null || agentDashboardModel.data.dailyData.comission == "" ? "N/A" : agentDashboardModel.data.dailyData.comission}"),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                saleInnerCard(context, "Weekly Sale".tr().toString(),
                    "${state is AgentDashboardInProgressState || agentDashboardModel.data.weeklyData.sales == null || agentDashboardModel.data.weeklyData.sales == "" ? "N/A" : agentDashboardModel.data.weeklyData.sales}"),
                saleInnerCard(context, "Weekly Commission".tr().toString(),
                    "${state is AgentDashboardInProgressState || agentDashboardModel.data.weeklyData.comission == null || agentDashboardModel.data.weeklyData.comission == "" ? "N/A" : agentDashboardModel.data.weeklyData.comission}"),
              ]),

              // Row(children:[]),
            ]),
      ),
    );
  }

  Widget totalSaleAndCommissionWidget(
      BuildContext context, AgentDashboardModel agentDashboardModel, state) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
          color: AppTheme.background2,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          totalSaleInnerCard(context, "Total Sale".tr().toString(),
              "${state is AgentDashboardInProgressState || agentDashboardModel.data.monthlyData.sales == null || agentDashboardModel.data.monthlyData.sales == "" ? "N/A" : agentDashboardModel.data.monthlyData.sales}"),
          totalSaleInnerCard(context, "Total Commission".tr().toString(),
              "${state is AgentDashboardInProgressState || agentDashboardModel.data.monthlyData.comission == null || agentDashboardModel.data.monthlyData.comission == "" ? "N/A" : agentDashboardModel.data.monthlyData.comission}"),
        ]),
      ),
    );
  }

  Widget availableForWithdrawWidget(
      BuildContext context, AgentDashboardModel agentDashboardModel, state) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
          color: AppTheme.background2,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          withdawInnerCardWidget(
              context,
              "Available for withdraw".tr().toString(),
              "${state is AgentDashboardInProgressState || agentDashboardModel.data.availableForWithdraw == null || agentDashboardModel.data.availableForWithdraw == null ? "N/A" : agentDashboardModel.data.availableForWithdraw}"),
        ]),
      ),
    );
  }

  Widget saleInnerCard(
      BuildContext context, String heading, String subHeading) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.38,
      height: MediaQuery.of(context).size.height * 0.128,
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
                .bodyText1
                .copyWith(color: Colors.black87),
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
      height: MediaQuery.of(context).size.height * 0.128,
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
                .copyWith(color: Colors.black87),
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
      height: MediaQuery.of(context).size.height * 0.128,
      decoration: BoxDecoration(
          color: AppTheme.background1,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(
            heading,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Colors.black87, fontSize: 13),
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
