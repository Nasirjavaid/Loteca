import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/lastRoundResultBloc/lastRoundResultBloc.dart';
import 'package:locteca/bloc/lastRoundResultBloc/lastRoundResultEvent.dart';
import 'package:locteca/bloc/lastRoundResultBloc/lastRoundResultState.dart';
import 'package:locteca/ui/CommonWidget/loadingIndicator.dart';
import 'package:locteca/ui/Screen/Result/packageWinnerWidget.dart';
import 'package:locteca/ui/Screen/Result/ranking.dart';
import 'package:locteca/ui/Screen/Result/roundDetailWidget.dart';
import '../../../config/appTheme.dart';

class RoundDetailScreenMain extends StatelessWidget {
  final int roundId;
  final String roundName;

  RoundDetailScreenMain({this.roundId, this.roundName});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) {
          return LastRoundResulBloc()
            ..add(GetRoundDetailEvent(
              roundId: roundId,
            ));
        },
        child: RoundDetailScreen(
          roundId: roundId,
          roundName: roundName,
        ),
      ),
    );
  }
}

class RoundDetailScreen extends StatefulWidget {
  final int roundId;
  final String roundName;
  RoundDetailScreen({this.roundId, this.roundName});
  @override
  _RoundDetailScreenState createState() => _RoundDetailScreenState();
}

class _RoundDetailScreenState extends State<RoundDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: DefaultTabController(
            length: 5,
            child: Scaffold(
                // extendBodyBehindAppBar: true,
                appBar: AppBar(
                  iconTheme: IconThemeData(color: Colors.black38),

                  // elevation: 0.0,
                  // actions: [
                  //   actionWidget(context),
                  // ],
                  // toolbarHeight: 50,
                  centerTitle: true,
                  // backgroundColor: AppTheme.appDefaultColor,

                  title: Text(
                    widget.roundName.tr().toString(),
                    style: Theme.of(context).textTheme.button.copyWith(
                        color: Colors.black38,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),

                  elevation: 0,
                  bottom: new PreferredSize(
                    preferredSize: new Size(0.0, 40.0),
                    child: TabBar(
                      labelStyle: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(fontSize: 10, fontWeight: FontWeight.w700),
                      isScrollable: true,
                      unselectedLabelColor: AppTheme.appDefaultColor,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppTheme.appDefaultColor,
                      ),
                      tabs: [
                        Container(
                          height: 30,
                          child: Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: AppTheme.appDefaultColor,
                                      width: 1)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0, vertical: 0),
                                  child: Text("Round Detail"),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          child: Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: AppTheme.appDefaultColor,
                                      width: 1)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0, vertical: 0),
                                  child: Text("First Package Winners"),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          child: Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: AppTheme.appDefaultColor,
                                      width: 1)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0, vertical: 0),
                                  child: Text("Second Package Winners"),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          child: Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: AppTheme.appDefaultColor,
                                      width: 1)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0, vertical: 0),
                                  child: Text("Third Package Winners"),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          child: Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: AppTheme.appDefaultColor,
                                      width: 1)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0, vertical: 0),
                                  child: Text("Leader Board"),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                body: BlocListener<LastRoundResulBloc, LastRoundResultState>(
                    listener: (BuildContext context, state) {
                  print(
                      "Printing state from bloc lstener, and state is :  $state");
                }, child: BlocBuilder<LastRoundResulBloc, LastRoundResultState>(
                  builder: (BuildContext context, state) {
                    if (state is LastRoundResultFailureState) {
                      return Center(child: failedWidget(context));
                    }
                    if (state is RoundDetailSuccessState) {
                      return TabBarView(
                        children: [
                          RoundDetailWidget(roundDetail: state.roundDetail),
                          PackageWinnerWidget(
                              packageWinners: state
                                  .roundDetail.winners.firstPackageWinners),
                          PackageWinnerWidget(
                              packageWinners: state
                                  .roundDetail.winners.secondPackageWinners),
                          PackageWinnerWidget(
                              packageWinners: state
                                  .roundDetail.winners.thirdPackageWinners),
                          Ranking(
                            leaderBoard: state.roundDetail.leaderBoard,userLogin:state.userLogin
                          )
                        ],
                      );
                    }
                    if (state is LastRoundResultInProgressState) {
                      return LoadingIndicator(AppTheme.appDefaultColor);
                    }
                    return Container();
                  },
                )))));
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
            .add(GetRoundDetailEvent(roundId: widget.roundId));
      },
    );
  }
}
