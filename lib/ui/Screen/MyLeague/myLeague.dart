import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/leaguesBloc/leaguesBloc.dart';
import 'package:locteca/bloc/leaguesBloc/leaguesEvent.dart';
import 'package:locteca/bloc/leaguesBloc/leaguesState.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/ui/CommonWidget/loadingIndicator.dart';
import 'package:locteca/ui/Screen/DashboardScreen/myNavDrawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grouped_list/grouped_list.dart';

class MyLeagueMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) {
          return LeaguesBloc()..add(GetLeaguesListEvent());
        },
        child: MyLeague(),
      ),
    );
  }
}

class MyLeague extends StatefulWidget {
  @override
  _MyLeagueState createState() => _MyLeagueState();
}

class _MyLeagueState extends State<MyLeague> with WidgetsBindingObserver {
  // List _elements = [
  //   {'name': 'John', 'group': 'Active League'},
  //   {'name': 'John mall', 'group': 'Active League'},
  //   {'name': 'Wada Mall', 'group': 'Active League'},
  //   {'name': 'Big Bond', 'group': 'Active League'},
  //   {'name': 'James Bond', 'group': 'Active League'},
  //   {'name': 'Chiita jhony', 'group': 'Active League'},
  //   {'name': 'Mango Topa', 'group': 'Closed League'},
  //   {'name': 'Dor Dor', 'group': 'Closed League'},
  //   {'name': 'Fity Mu', 'group': 'Closed League'},
  //   {'name': 'Chal Chuti kr', 'group': 'Closed League'},
  //   {'name': 'Chal Chuti kr', 'group': 'Closed League'},
  //   {'name': 'Chal Chuti kr', 'group': 'Closed League'},
  //   {'name': 'Chal Chuti kr', 'group': 'Closed League'},
  //   {'name': 'Chal Chuti kr', 'group': 'Closed League'},
  //   {'name': 'Chal Chuti kr', 'group': 'Closed League'},
  //   {'name': 'Chal Chuti kr', 'group': 'Closed League'},
  //   {'name': 'Chal Chuti kr', 'group': 'Closed League'},
  //   {'name': 'Chal Chuti kr', 'group': 'Closed League'},
  //   {'name': 'Chal Chuti kr', 'group': 'Closed League'},
  // ];
   @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
   @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        BlocProvider.of<LeaguesBloc>(context).add(GetLeaguesListEvent());
        break;
      case AppLifecycleState.inactive:
        //onPaused();
        break;
      case AppLifecycleState.paused:
       // onInactive();
        break;
      case AppLifecycleState.detached:
        //onDetached();
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          //  extendBodyBehindAppBar: true,
          //backgroundColor: AppTheme.background,
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
            title: Text(
              "My Leagues",
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
                  "Active Leagues",
                  style: Theme.of(context).textTheme.button.copyWith(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                )),
                Tab(
                    icon: Text(
                  "Closed Leagues",
                  style: Theme.of(context).textTheme.button.copyWith(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                )),
                Tab(
                    icon: Text(
                  "Inited Leagues",
                  style: Theme.of(context).textTheme.button.copyWith(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                )),
              ],
            ),
          ),

          body: BlocListener<LeaguesBloc, LeaguesState>(
              listener: (BuildContext context, state) {
            print("Printing state from bloc lstener, and state is :  $state");
          }, child: BlocBuilder<LeaguesBloc, LeaguesState>(
            builder: (BuildContext context, state) {
              if (state is LeaguesFailureState) {
                return Center(child: failedWidget(context));
              }
              if (state is LeaguesSuccessState) {
                return TabBarView(
                  children: [
                    // groupedList(context),
                    listofTeams(context, state.leaguesModel.activeLeagues),
                    listofTeams(context, state.leaguesModel.closedLeagues),
                    listofTeams(
                        context, state.leaguesModel.participatedLeagues),
                  ],
                );
              }
              if (state is LeaguesInProgressState) {
                return LoadingIndicator(Colors.indigo);
              }
              return Container();
            },
          )),

          drawer: MyNaveDrawerMain(),
        ),
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
        BlocProvider.of<LeaguesBloc>(context).add(GetLeaguesListEvent());
      },
    );
  }

  // Widget groupedList(BuildContext context) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width * 0.95,
  //     child: GroupedListView<dynamic, String>(
  //       elements: _elements,
  //       groupBy: (element) => element['group'],
  //       groupComparator: (value1, value2) => value2.compareTo(value1),
  //       itemComparator: (item1, item2) =>
  //           item1['name'].compareTo(item2['name']),
  //       order: GroupedListOrder.DESC,
  //       useStickyGroupSeparators: true,
  //       groupSeparatorBuilder: (String value) => Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: creditWidget(context, value)),
  //       itemBuilder: (c, element) {
  //         return listWiewItemCard(context);
  //       },
  //     ),
  //   );
  // }

  Widget creditWidget(BuildContext context, String text) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.background2,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 25),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(FontAwesomeIcons.peopleCarry,
                size: 20, color: AppTheme.nearlyGold),
            SizedBox(
              width: 14,
            ),
            Text(text,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: AppTheme.appDefaultColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }

  Widget listofTeams(BuildContext context, List<dynamic> genericListOfLeagues) {
    return Container(
      //  height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width * 0.90,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(0),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 5),
            itemCount: genericListOfLeagues.length == 0
                ? 1
                : genericListOfLeagues.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return genericListOfLeagues.length != 0
                  ? listWiewItemCard(context, genericListOfLeagues[index])
                  : Center(
                      child: Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Text("No Items"),
                    ));
            }),
      ),
    );
  }

  Widget listWiewItemCard(BuildContext context, dynamic leaguesItem) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          )),
      margin: EdgeInsets.symmetric(vertical: 1, horizontal: 6),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                Icons.gamepad,
                size: 50,
                color: Colors.blue,
              ),
            ),
            SizedBox(
              width: 7,
            ),
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    leaguesItem.name == null || leaguesItem.name == ""
                        ? "N/A"
                        : leaguesItem.name,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.w800,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Startting Date",
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.black38,
                            ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.all(
                              Radius.circular(2),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 8),
                          child: Text(
                            "${leaguesItem.startingDate == null || leaguesItem.startingDate == "" ? "N/A" : leaguesItem.startingDate}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                    color: Colors.blue[900],
                                    fontWeight: FontWeight.w600),
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
                    children: [
                      Text(
                        "Ending Date ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black38),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.all(
                              Radius.circular(2),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 8),
                          child: Text(
                            "${leaguesItem.endingDate == null || leaguesItem.endingDate == "" ? "N/A" : leaguesItem.endingDate} ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                    color: Colors.red[900],
                                    fontWeight: FontWeight.w600),
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
    );
  }
}
