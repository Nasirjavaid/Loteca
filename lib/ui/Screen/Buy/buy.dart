import 'package:flutter/material.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/config/methods.dart';
import 'package:locteca/ui/Screen/GeneralRanking/generalRanking.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locteca/ui/Screen/DashboardScreen/myNavDrawer.dart';

class Buy extends StatefulWidget {
  @override
  _BuyState createState() => _BuyState();
}

class _BuyState extends State<Buy> {
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
                FontAwesomeIcons.questionCircle,
                color: Colors.white38,
                size: 18,
              ),
              onPressed: null),
        ],
        title: Text(
          "Buy",
          style: Theme.of(context).textTheme.button.copyWith(
              color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w700),
        ),

        centerTitle: true,
        // backgroundColor: AppTheme.appDefaultColor,

        backgroundColor: AppTheme.appDefaultColor,
      ),
      body: _buildBody(context),
      drawer: MyNaveDrawerMain(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      //  color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: listofTeams(context),
    );
  }

  Widget listofTeams(BuildContext context) {
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
            itemCount: 20,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return listWiewItemCard(context);
            }),
      ),
    );
  }

  Widget listWiewItemCard(BuildContext context) {
    return InkWell(
      highlightColor: Colors.amber,
      onTap: () {
        Methods.showDialogWithAgentDetail(context);
      },
      child: Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.6),
          child: Container(
           
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(3),
                )),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                            imageUrl:
                                "https://cdn.pixabay.com/photo/2018/08/26/23/55/woman-3633737__340.jpg",
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Agent Name",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Per coin rate : \$5",
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: Colors.black45,
                                    ),
                          ),
                          Text(
                            "Total avilable Coins: 267",
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: Colors.black45,
                                    ),
                          ),
                          Text(
                            "Address : Temple Road  GT# 12",
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: Colors.black45,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  creditWidget(context),
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
        ),
      ),
    );
  }

  Widget creditWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon(FontAwesomeIcons.coins, size: 20, color: AppTheme.nearlyGold),
            // SizedBox(
            //   width: 14,
            // ),
            Text("Available",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.green,
                    fontSize: 10,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
