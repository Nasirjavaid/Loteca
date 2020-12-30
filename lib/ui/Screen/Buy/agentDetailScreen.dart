import 'package:flutter/material.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/ui/CommonWidget/roundedImageViewWithoutBorderDynamic.dart';
import 'package:locteca/ui/Screen/GeneralRanking/generalRanking.dart';

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
              leading: Container(),
              backgroundColor: AppTheme.appDefaultColor,
              elevation: 0,
              actions: [
                actionWidget(context),
              ]),
          body: _buildBody(context),
        ),
      ),
    );
  }

  Widget actionWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Avatar(
        circleShow: false,
        circleColor: Colors.green,
        circleHeight: 22,
        circleWidth: 22,
        height: 45,
        width: 45,
        imageUrl:
            "https://cdn.pixabay.com/photo/2018/08/26/23/55/woman-3633737__340.jpg",
        radius: 40,
        backgroundColor: Colors.white,
        borderColor: Colors.grey,
        borderWidth: 1.0,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.21,
        decoration: BoxDecoration(
            color: AppTheme.appDefaultColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
      ),
      innerBodyOfStack(context),
    ]);
  }

  Widget innerBodyOfStack(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
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
                    elevation: 12,
                    color: Colors.transparent,
                    child: RoundedCornerImageViewWithoutBorderDynamic(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.16,
                      imageLink:
                          "https://cdn.pixabay.com/photo/2018/08/26/23/55/woman-3633737__340.jpg",
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
                          "Agent Name",
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
                              "Avilable Coins:    ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(color: Colors.black87),
                            ),
                            Text(
                              "576",
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
                          "Phone:      34567890-098",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.black87),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Address:  Temple Road GT No. 59-BT-9",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.black87),
                        ),
                      ]),
                )),
              ]),
            ),
            SizedBox(
              height: 12,
            ),
            sendCoinsButton(context),
            SizedBox(
              height: 12,
            ),
            perDayAndWeeklySaleWidget(context),
            SizedBox(
              height: 12,
            ),
            totalSaleAndCommissionWidget(context)
          ],
        ),
      ),
    );
  }

  Widget sendCoinsButton(BuildContext context) {
    return InkWell(
      onTap: () {},
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
          "Send Coins",
          style: Theme.of(context).textTheme.bodyText2.copyWith(
              color: AppTheme.appCardColor,
              fontSize: 16,
              fontWeight: FontWeight.w900),
        )),
      ),
    );
  }

  Widget perDayAndWeeklySaleWidget(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
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
                saleInnerCard(context, "Today Sale", "35"),
                saleInnerCard(context, "Today Commission", "20")
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                saleInnerCard(context, "Weekly Sale", "4637"),
                saleInnerCard(context, "Weekly Commission", "33948")
              ]),

              // Row(children:[]),
            ]),
      ),
    );
  }

  Widget totalSaleAndCommissionWidget(BuildContext context) {
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
          totalSaleInnerCard(context, "Total Sale", "1650"),
          totalSaleInnerCard(context, "Total Commission", "135")
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
                fontSize: 25,
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
                .copyWith(color: Colors.black87, fontSize: 16),
          ),
          // SizedBox(
          //   height: 18,
          // ),
          Text(
            subHeading,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: AppTheme.appDefaultColor,
                fontSize: 30,
                fontWeight: FontWeight.w900),
          ),
        ]),
      ),
    );
  }
}
