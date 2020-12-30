import 'package:flutter/material.dart';
import 'package:locteca/config/appTheme.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locteca/ui/Screen/DashboardScreen/myNavDrawer.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white38),

        elevation: 0.0,
        actions: [
          IconButton(
              icon: Icon(
                FontAwesomeIcons.search,
                color: Colors.white38,
                size: 18,
              ),
              onPressed: null),
        ],
        // toolbarHeight: 50,
        centerTitle: true,
        backgroundColor: AppTheme.appDefaultColor,

        title: Text(
          "Recent Closed Round",
          style: Theme.of(context).textTheme.button.copyWith(
              color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: _buildBody(context),
      drawer: MyNaveDrawerMain(),
    );
  }

  Widget _buildBody(BuildContext context) {
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
          headingCard(context),
          listofTeams(context),
        ],
      ),
    );
  }

  Widget listofTeams(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.73,
      decoration: BoxDecoration(
          // color: AppTheme.appCardColor,
          borderRadius: BorderRadius.all(
        Radius.circular(15),
      )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 3),
        child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: 20,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return listWiewItemCard(context);
            }),
      ),
    );
  }

  Widget listWiewItemCard(BuildContext context) {
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
              creditWidget(context, 10, AppTheme.background, "Australia", 14,
                  FontWeight.w900, Colors.black54),
              creditWidget(context, 10, AppTheme.background, "England", 14,
                  FontWeight.w900, Colors.black54),
              creditWidget(context, 10, AppTheme.background, "Australia", 14,
                  FontWeight.w900, Colors.cyan),
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
            color: Colors.blue[100],
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              creditWidgetTwo(context, 10, AppTheme.pieChartBackgroundColor1, "Team A", 15,
                  FontWeight.w900, AppTheme.appDefaultColor),
              creditWidgetTwo(context, 10, AppTheme.pieChartBackgroundColor1, "Team B", 15,
                  FontWeight.w900, AppTheme.appDefaultColor),
              creditWidgetTwo(context, 10, AppTheme.pieChartBackgroundColor1, "Winner", 15,
                  FontWeight.w900, AppTheme.appDefaultColor),
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
    return Container(
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(
            Radius.circular(cornerRadius),
          )),
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
