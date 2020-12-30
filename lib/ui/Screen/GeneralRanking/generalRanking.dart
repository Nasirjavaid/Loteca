import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/ui/CommonWidget/circulerImageView.dart';

import 'package:locteca/ui/Screen/DashboardScreen/myNavDrawer.dart';

class GeneralRanking extends StatefulWidget {
  @override
  _GeneralRankingState createState() => _GeneralRankingState();
}

class _GeneralRankingState extends State<GeneralRanking> {
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
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.questionCircle,
                    color: Colors.white38,
                    size: 18,
                  ),
                  onPressed: null),
            ],
            // toolbarHeight: 50,
            centerTitle: true,
            // backgroundColor: AppTheme.appDefaultColor,

            title: Text(
              "Ranking",
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
                  "This Month",
                  style: Theme.of(context).textTheme.button.copyWith(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                )),
                Tab(
                    icon: Text(
                  "All Time",
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
              _buildBodyForThisMonth(context),
              listofTeams(context),
            ],
          ),
          drawer: MyNaveDrawerMain(),
        ),
      ),
    );
  }

  Widget _buildBodyForThisMonth(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Column(
        children: [postionedBaseUserCards(), listofTeams(context)],
      )),
    );
  }

  Widget postionedBaseUserCards() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          children: [
            Avatar(
              circleShow: true,
              circleColor: Colors.blueGrey,
              circleHeight: 22,
              circleWidth: 22,
              height: 65,
              width: 65,
              imageUrl:
                  "https://cdn.pixabay.com/photo/2018/08/26/23/55/woman-3633737__340.jpg",
              radius: 40,
              backgroundColor: Colors.white,
              borderColor: Colors.grey.shade300,
              borderWidth: 4.0,
            ),
            SizedBox(
              height: 15,
            ),
            Text("Mango BiBi",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: AppTheme.appBackgroundColorforCard1,
                    fontSize: 12,
                    fontWeight: FontWeight.w900)),
            SizedBox(
              height: 8,
            ),
            creditWidget(context, Colors.amberAccent),
          ],
        ),
        Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Avatar(
              circleShow: true,
              circleColor: Colors.green,
              circleHeight: 32,
              circleWidth: 32,
              height: 100,
              width: 100,
              imageUrl:
                  "https://fastly.syfy.com/sites/syfy/files/styles/1170xauto/public/dummy-murdock1.jpg",
              radius: 40,
              backgroundColor: Colors.white,
              borderColor: Colors.grey.shade300,
              borderWidth: 4.0,
            ),
            SizedBox(
              height: 15,
            ),
            Text("Mango",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: AppTheme.appBackgroundColorforCard1,
                    fontSize: 16,
                    fontWeight: FontWeight.w900)),
            SizedBox(
              height: 8,
            ),
            creditWidget(context, Colors.blueGrey[100]),
            SizedBox(
              height: 0,
            )
          ],
        ),
        Column(
          children: [
            Avatar(
              circleShow: true,
              circleColor: Colors.amber,
              circleHeight: 22,
              circleWidth: 22,
              height: 65,
              width: 65,
              imageUrl:
                  "https://cdn.pixabay.com/photo/2018/08/26/23/55/woman-3633737__340.jpg",
              radius: 40,
              backgroundColor: Colors.white,
              borderColor: Colors.grey.shade300,
              borderWidth: 4.0,
            ),
            SizedBox(
              height: 10,
            ),
            Text("Mango BiBi",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: AppTheme.appBackgroundColorforCard1,
                    fontSize: 12,
                    fontWeight: FontWeight.w900)),
            SizedBox(
              height: 8,
            ),
            creditWidget(
              context,
              AppTheme.background3,
            ),
          ],
        ),
      ],
    ));
  }

  Widget creditWidget(BuildContext context, Color backgroundColor) {
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
            Icon(FontAwesomeIcons.coins, size: 14, color: AppTheme.nearlyGold),
            SizedBox(
              width: 12,
            ),
            Text("345",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: AppTheme.appDefaultColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }

  Widget creditWidgetForListItemCard(
      BuildContext context, Color backgroundColor) {
    return Container(
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
            Icon(FontAwesomeIcons.coins, size: 12, color: AppTheme.nearlyGold),
            SizedBox(
              width: 8,
            ),
            Text("345",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: AppTheme.appDefaultColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }

  Widget listofTeams(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        width: MediaQuery.of(context).size.width * 0.95,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: 7,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return listWiewItemCard(context, index);
              }),
        ),
      ),
    );
  }

  Widget listWiewItemCard(BuildContext context, int index) {
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
                  imageUrl:
                      "https://cdn.pixabay.com/photo/2018/08/26/23/55/woman-3633737__340.jpg",
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
            creditWidgetForListItemCard(
              context,
              AppTheme.background3,
            ),
          ],
        ),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar(
      {Key key,
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
      this.circleShow})
      : super(key: key);

  final double height, width;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final String imageUrl;
  final double radius;
  final bool circleShow;
  final double circleHeight;
  final double circleWidth;
  final Color circleColor;

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
                    child: Center(
                      child: Text(
                        "1",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
