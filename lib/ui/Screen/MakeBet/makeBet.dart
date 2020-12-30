import 'package:flutter/material.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locteca/ui/Screen/DashboardScreen/myNavDrawer.dart';

class MakeBet extends StatefulWidget {
  @override
  _MakeBetState createState() => _MakeBetState();
}

class _MakeBetState extends State<MakeBet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.appDefaultColor,
      child: SafeArea(
        maintainBottomViewPadding: true,
        child: Scaffold(
          extendBodyBehindAppBar: true,
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
            backgroundColor: Colors.transparent,
            // title: Text(
            //   "Loteca",
            //   style:
            //       Theme.of(context).textTheme.button.copyWith(color: Colors.white),
            // ),
          ),
          backgroundColor: AppTheme.appDefaultColor,
          body: _buildBody(context),
          drawer: MyNaveDrawerMain(),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          liveTeamTagWidget(context),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          teamNameText(context),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          listofTeams(context),
          Spacer(),
          bottomCard(context),
        ],
      ),
    );
  }

  Widget liveTeamTagWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.background1,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 22),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("LIVE",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: AppTheme.appDefaultColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w900)),
            SizedBox(
              width: 14,
            ),
            Icon(
              FontAwesomeIcons.dotCircle,
              size: 16,
              color: AppTheme.appDefaultColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget teamNameText(BuildContext context) {
    return Text(
      "England Premier League",
      style: Theme.of(context).textTheme.bodyText2.copyWith(
          color: Colors.white60, fontSize: 22, fontWeight: FontWeight.w900),
    );
  }

  Widget listofTeams(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.43,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: AppTheme.appCardColor,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: 20,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return listWiewItemCard(context);
            }),
      ),
    );
  }

  Widget listWiewItemCard(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Icon(
              Icons.flag,
              size: 25,
              color: Colors.white,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              "Team Name",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white60),
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.close,
            size: 30,
            color: Colors.white,
          ),
        ),
        Row(
          children: [
            Text(
              "Team Name",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white60),
            ),
            SizedBox(
              width: 4,
            ),
            Icon(
              Icons.flag,
              size: 25,
              color: Colors.white,
            ),
          ],
        ),
      ],
    );
  }

  Widget bottomCard(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.28,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(75), topRight: Radius.circular(75))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          creditWidget(context),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          selectAmoutWidget(),
          Spacer(),
          submitButton(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.010,
          ),
        ],
      ),
    );
  }

  Widget creditWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.background1,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 25),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(FontAwesomeIcons.coins, size: 20, color: AppTheme.nearlyGold),
            SizedBox(
              width: 14,
            ),
            Text("345",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: AppTheme.appDefaultColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }

  Widget selectAmoutWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Choose Amount ",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: AppTheme.appBackgroundColorforCard1,
                        fontSize: 16,
                        fontWeight: FontWeight.w900)),
                Container(
                  height: 1,
                  color: AppTheme.background1,
                  width: MediaQuery.of(context).size.width * 0.55,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppTheme.background1,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Rs: 345",
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: AppTheme.appDefaultColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                      SizedBox(
                        height: 2,
                      ),
                      Text("Accumulate Rs: 56",
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: Colors.black26,
                              fontSize: 10,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppTheme.background1,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Rs: 345",
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: AppTheme.appDefaultColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                      SizedBox(
                        height: 2,
                      ),
                      Text("Accumulate Rs: 56",
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: Colors.black26,
                              fontSize: 10,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppTheme.background1,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Rs: 345",
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: AppTheme.appDefaultColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                      SizedBox(
                        height: 2,
                      ),
                      Text("Accumulate Rs: 56",
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: Colors.black26,
                              fontSize: 10,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget submitButton() {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.047,
      width: MediaQuery.of(context).size.width * 0.95,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: Container(
          // margin: EdgeInsets.only(top: 0.0),
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            gradient: new LinearGradient(
                colors: [AppTheme.appDefaultColor, AppTheme.appCardColor],
                begin: const FractionalOffset(0.0, 1.0),
                end: const FractionalOffset(0.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: MaterialButton(
              highlightColor: AppTheme.appDefaultButtonSplashColor,
              splashColor: AppTheme.appDefaultButtonSplashColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2.0))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),

//checking user before placing the order
                // child: guestUserValue
                //     ? Text("Sign In",
                //         style: Theme.of(context).textTheme.bodyText2.copyWith(
                //             fontWeight: FontWeight.w600, color: Colors.white))
                //     : Text("Check out",
                //         style: Theme.of(context).textTheme.bodyText2.copyWith(
                //             fontWeight: FontWeight.w600, color: Colors.white)),

                child: Text("Submit",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white)),
              ),
              onPressed: () async {
                print("submit button pressed");

                // NetworkConnectivity.check().then((internet) {
                //   if (internet) {
                //     placeOrder();
                //   } else {
                //     //show network erro

                //     Methods.showToast(context, "Check your network");
                //   }
                // });
              }),
        ),
      ),
    );
  }
}
