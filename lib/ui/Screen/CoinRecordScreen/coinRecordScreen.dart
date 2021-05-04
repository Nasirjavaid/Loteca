import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/coinRecordBloc/coinRecordBloc.dart';
import 'package:locteca/bloc/coinRecordBloc/coinRecordEvent.dart';
import 'package:locteca/bloc/coinRecordBloc/coinRecordState.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/model/coinRecord.dart';
import 'package:locteca/ui/CommonWidget/commonWidgets.dart';
import 'package:locteca/ui/CommonWidget/loadingIndicator.dart';
import 'package:locteca/ui/Screen/CoinRecordScreen/reciptScreen.dart';
import 'package:locteca/ui/Screen/GeneralRanking/generalRanking.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class CoinRecordScreenMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) {
          return CoinRecordBloc()..add(GetCoinRecordEvent());
        },
        child: CoinRecordScreen(),
      ),
    );
  }
}

class CoinRecordScreen extends StatefulWidget {
  @override
  _CoinRecordScreenState createState() => _CoinRecordScreenState();
}

class _CoinRecordScreenState extends State<CoinRecordScreen> {
  CoinRecord coinRecordGlobal = CoinRecord();
  Widget actionWidget(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              BlocProvider.of<CoinRecordBloc>(context)
                  .add(GetCoinRecordEvent());
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: AppTheme.background,
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white38),

                elevation: 0.0,
                actions: [actionWidget(context)],
                title: Text(
                  "Historico De Transacoes",
                  style: Theme.of(context).textTheme.button.copyWith(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),

                centerTitle: true,
                // backgroundColor: AppTheme.appDefaultColor,

                backgroundColor: AppTheme.appDefaultColor,
                bottom: TabBar(
                  tabs: [
                    Tab(
                        icon: Text(
                      "Coin History".tr().toString(),
                      style: Theme.of(context).textTheme.button.copyWith(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    )),
                    Tab(
                        icon: Text(
                      "Bet History".tr().toString(),
                      style: Theme.of(context).textTheme.button.copyWith(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    )),
                  ],
                ),
              ),
              // body: _buildBody(context),

              body: BlocListener<CoinRecordBloc, CoinRecordState>(
                  listener: (BuildContext context, state) {
                print(
                    "Printing state from bloc lstener, and state is :  $state");
              }, child: BlocBuilder<CoinRecordBloc, CoinRecordState>(
                builder: (BuildContext context, state) {
                  if (state is CoinRecordFailureState) {
                    return Center(child: failedWidget(context));
                  }
                  if (state is CoinRecordSuccessState) {
                    coinRecordGlobal = state.coinRecord;
                    return TabBarView(
                      children: [
                        _buildBodyForCoinHistory(
                            context, state.coinRecord.coinHistory),
                        _buildBodyForBetHistory(
                            context, state.coinRecord.betHistory),
                      ],
                    );
                  }
                  if (state is UserCoinRecordReciptInProgressState) {
                    return Stack(
                      children: [
                        TabBarView(
                          children: [
                            _buildBodyForCoinHistory(
                                context, coinRecordGlobal.coinHistory),
                            _buildBodyForBetHistory(
                                context, coinRecordGlobal.betHistory),
                          ],
                        ),
                        Center(child: CommonWidgets.progressIndicatorCustom),
                      ],
                    );
                  }
                  if (state is CoinRecordInProgressState) {
                    return LoadingIndicator(Colors.indigo);
                  }
                  return Container();
                },
              )),
            )));
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
        BlocProvider.of<CoinRecordBloc>(context).add(GetCoinRecordEvent());
      },
    );
  }

  Widget _buildBodyForCoinHistory(BuildContext context, dynamic coinRecord) {
    return Container(
      //  color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: listoodcoinRecord(context, coinRecord),
    );
  }

  Widget listoodcoinRecord(
      BuildContext context, List<CoinHistory> coinHistory) {
    return Container(
      decoration: BoxDecoration(
          // color: AppTheme.appCardColor,
          borderRadius: BorderRadius.all(
        Radius.circular(15),
      )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 3),
        child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: coinHistory.length == 0 ? 1 : coinHistory.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return coinHistory.length == 0
                  ? Center(
                      child: Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Text(
                        "No Items".tr().toString(),
                      ),
                    ))
                  : coinHistorylistWiewItemCard(context, coinHistory[index]);
              // return listWiewItemCard(context);
            }),
      ),
    );
  }

  Widget coinHistorylistWiewItemCard(
      BuildContext context, CoinHistory records) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReciptScreenMain(
                  id: records.recordId, apiDirectionalCall: 1)),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 6,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.6),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                )),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
              child: Row(
                children: [
                  Row(
                    children: [
                      Avatar(
                        circleShow: false,
                        circleColor: Colors.amber,
                        circleHeight: 22,
                        circleWidth: 22,
                        height: 60,
                        width: 60,
                        imageUrl: records.image == null || records.image == ""
                            ? "https://cdn.pixabay.com/photo/2018/08/26/23/55/woman-3633737__340.jpg"
                            : records.image,
                        radius: 40,
                        backgroundColor: Colors.white,
                        borderColor: Colors.grey.shade300,
                        borderWidth: 4.0,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              //  agents.name == null || agents.name ==""? "Agent Name".tr().toString() : agents.name ,
                              "Name".tr().toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                      fontSize: 12.5,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w700),
                            ),
                            Text(
                              records.userName == null || records.userName == ""
                                  ? "N/A".tr().toString()
                                  : records.userName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                      fontSize: 12.5,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Transfered Coins".tr().toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: Colors.black45, fontSize: 10),
                            ),
                            Text(
                              "${records.transferredCoins == null || records.transferredCoins == "" ? "" : records.transferredCoins}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: Colors.black45, fontSize: 10),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Transfer Date".tr().toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: Colors.black45, fontSize: 10),
                            ),
                            Text(
                              "${records.transferDate == null || records.transferDate == "" ? "" : todayDate(records.transferDate)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: Colors.black45, fontSize: 10),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Phone".tr().toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: Colors.black45, fontSize: 10),
                            ),
                            Text(
                              "${records.userPhone == null || records.userPhone == "" ? "" : records.userPhone}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: Colors.black45, fontSize: 10),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Email".tr().toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: Colors.black45, fontSize: 10),
                            ),
                            Text(
                              "${records.userEmail == null || records.userEmail == "" ? "" : records.userEmail}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: Colors.black45, fontSize: 10),
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
        ),
      ),
    );
  }

  Widget _buildBodyForBetHistory(BuildContext context, dynamic betHistory) {
    return Container(
      //  color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: listofBetRecord(context, betHistory),
    );
  }

  Widget listofBetRecord(BuildContext context, List<BetHistory> coinHistory) {
    return Container(
      decoration: BoxDecoration(
          // color: AppTheme.appCardColor,
          borderRadius: BorderRadius.all(
        Radius.circular(15),
      )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 3),
        child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: coinHistory.length == 0 ? 1 : coinHistory.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return coinHistory.length == 0
                  ? Center(
                      child: Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Text(
                        "No Items".tr().toString(),
                      ),
                    ))
                  : betHistorylistWiewItemCard(context, coinHistory[index]);
              // return listWiewItemCard(context);
            }),
      ),
    );
  }

  Widget betHistorylistWiewItemCard(BuildContext context, BetHistory records) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReciptScreenMain(
                  id: records.recordId, apiDirectionalCall: 2)),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 6,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.6),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                )),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
              child: Row(
                children: [
                  Row(
                    children: [
                      Avatar(
                        circleShow: false,
                        circleColor: Colors.amber,
                        circleHeight: 22,
                        circleWidth: 22,
                        height: 60,
                        width: 60,
                        imageUrl: records.image == null || records.image == ""
                            ? "https://cdn.pixabay.com/photo/2018/08/26/23/55/woman-3633737__340.jpg"
                            : records.image,
                        radius: 40,
                        backgroundColor: Colors.white,
                        borderColor: Colors.grey.shade300,
                        borderWidth: 4.0,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              //  agents.name == null || agents.name ==""? "Agent Name".tr().toString() : agents.name ,
                              "Name".tr().toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                      fontSize: 12.5,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w700),
                            ),
                            Text(
                              records.userName == null || records.userName == ""
                                  ? "N/A".tr().toString()
                                  : records.userName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                      fontSize: 12.5,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Coins Used".tr().toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: Colors.black45, fontSize: 10),
                            ),
                            Text(
                              "${records == null || records.coinsUsed == "" ? "" : records.coinsUsed}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: Colors.black45, fontSize: 10),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Bet Date".tr().toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: Colors.black45, fontSize: 10),
                            ),
                            Text(
                              "${records.betDate == null || records.betDate == "" ? "" : todayDate(records.betDate)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: Colors.black45, fontSize: 10),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Phone".tr().toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: Colors.black45, fontSize: 10),
                            ),
                            Text(
                              "${records.userPhone == null || records.userPhone == "" ? "" : records.userPhone}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: Colors.black45, fontSize: 10),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Email".tr().toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: Colors.black45, fontSize: 10),
                            ),
                            Text(
                              "${records.userEmail == null || records.userEmail == "" ? "" : records.userEmail}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: Colors.black45, fontSize: 10),
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
        ),
      ),
    );
  }

  Widget creditWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(FontAwesomeIcons.userCheck, size: 11, color: Colors.blue),
              // SizedBox(
              //   width: 8,
              // ),
              // Text("",
              //     style: Theme.of(context).textTheme.bodyText2.copyWith(
              //         color: Colors.blue,
              //         fontSize: 9,
              //         fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }

  todayDate(String dateAntime) {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy kk:mm:a');

    String formattedDate = formatter.format(DateTime.parse(dateAntime));

    return formattedDate;
  }
}
