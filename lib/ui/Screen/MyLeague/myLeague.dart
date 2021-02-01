import 'package:flutter/material.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/ui/Screen/DashboardScreen/myNavDrawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grouped_list/grouped_list.dart';

class MyLeague extends StatefulWidget {
  @override
  _MyLeagueState createState() => _MyLeagueState();
}

class _MyLeagueState extends State<MyLeague> {
  List _elements = [
    {'name': 'John', 'group': 'Active League'},
    {'name': 'John mall', 'group': 'Active League'},
    {'name': 'Wada Mall', 'group': 'Active League'},
    {'name': 'Big Bond', 'group': 'Active League'},
    {'name': 'James Bond', 'group': 'Active League'},
    {'name': 'Chiita jhony', 'group': 'Active League'},
    {'name': 'Mango Topa', 'group': 'Closed League'},
    {'name': 'Dor Dor', 'group': 'Closed League'},
    {'name': 'Fity Mu', 'group': 'Closed League'},
    {'name': 'Chal Chuti kr', 'group': 'Closed League'},
    {'name': 'Chal Chuti kr', 'group': 'Closed League'},
    {'name': 'Chal Chuti kr', 'group': 'Closed League'},
    {'name': 'Chal Chuti kr', 'group': 'Closed League'},
    {'name': 'Chal Chuti kr', 'group': 'Closed League'},
    {'name': 'Chal Chuti kr', 'group': 'Closed League'},
    {'name': 'Chal Chuti kr', 'group': 'Closed League'},
    {'name': 'Chal Chuti kr', 'group': 'Closed League'},
    {'name': 'Chal Chuti kr', 'group': 'Closed League'},
    {'name': 'Chal Chuti kr', 'group': 'Closed League'},
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          //  extendBodyBehindAppBar: true,
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
                  "Participated",
                  style: Theme.of(context).textTheme.button.copyWith(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                )),
              ],
            ),
          ),
          body: TabBarView(
            children: [
             // groupedList(context),
              listofTeams(context),
              listofTeams(context),
              listofTeams(context),
              
            ],
          ),
          drawer: MyNaveDrawerMain(),
        ),
      ),
    );
  }

  Widget groupedList(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      child: GroupedListView<dynamic, String>(
        elements: _elements,
        groupBy: (element) => element['group'],
        groupComparator: (value1, value2) => value2.compareTo(value1),
        itemComparator: (item1, item2) =>
            item1['name'].compareTo(item2['name']),
        order: GroupedListOrder.DESC,
        useStickyGroupSeparators: true,
        groupSeparatorBuilder: (String value) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: creditWidget(context, value)),
        itemBuilder: (c, element) {
          return listWiewItemCard(context);
        },
      ),
    );
  }

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

  Widget listofTeams(BuildContext context) {
    return Container(
      //  height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width * 0.90,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(0),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 10),
            itemCount: 20,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return listWiewItemCard(context);
            }),
      ),
    );
  }

  Widget listWiewItemCard(BuildContext context) {
    return Card(
  margin:  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.theater_comedy,
              size: 35,
              color: Colors.blue,
            ),
            SizedBox(
              width: 7,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Team Name",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.black38),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "Points: 2345",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black38),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
