import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:locteca/config/appTheme.dart';

import 'package:locteca/model/roundDetail.dart';
import 'package:locteca/ui/CommonWidget/circulerStaticImageView.dart';

class RoundDetailWidget extends StatefulWidget {
  final RoundDetail roundDetail;
  RoundDetailWidget({this.roundDetail});
  @override
  _RoundDetailWidgetState createState() => _RoundDetailWidgetState();
}

class _RoundDetailWidgetState extends State<RoundDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildBody(context, widget.roundDetail);
  }

  Widget _buildBody(BuildContext contex, RoundDetail roundDetail) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Container(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                _topWidget(context, roundDetail),
                SizedBox(
                  height: 10,
                ),

               
              ],
            )),
            roundDetail.answers == null
                ? SliverToBoxAdapter()
                : SliverToBoxAdapter(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 6,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          textDynamicWidget(context, "Round Answers"),
                          _resultWidget(context, roundDetail.answers),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _topWidget(BuildContext context, RoundDetail roundDetail) {
    return Card(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 6,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          //color: AppTheme.appDefaultColor2,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 15,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  CirculerStaticImageView(
                      height: 60,
                      width: 60,
                      imageUrl: 'assets/images/icon.png'),
                  SizedBox(width: 8),
                  Text(
                    roundDetail.round.name == null ||
                            roundDetail.round.name == ""
                        ? "N/A"
                        : roundDetail.round.name,
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                ]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        roundDetail.round.startingDate == null ||
                                roundDetail.round.startingDate == ""
                            ? "N/A"
                            : "Starting Date".tr().toString() +
                                " : " +
                                roundDetail.round.startingDate,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.black45, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        roundDetail.round.endingDate == null ||
                                roundDetail.round.endingDate == ""
                            ? "N/A"
                            : "Ending Date".tr().toString() +
                                " :   " +
                                roundDetail.round.endingDate,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.black45, fontWeight: FontWeight.w500),
                      ),
                    ])
              ],
            ),

            // Text(
            //   "Leader Board",
            //   style: Theme.of(context).textTheme.button.copyWith(fontSize: 18),
            // ),
          ]),
        ),
      ),
    );
  }

  Widget _resultWidget(BuildContext context, dynamic dynamicAnswers) {
    return SizedBox(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext contex, int index) {
          return dynamicAnswers.length != 0
              ? listWiewItemCard(contex, dynamicAnswers[index])
              : Center(
                  child: Text(
                    "No itmes".tr().toString(),
                  ),
                );
        },
        itemCount: dynamicAnswers.length == 0 ? 1 : dynamicAnswers.length,
      ),
    );
  }

  Widget listWiewItemCard(BuildContext context, dynamic answers) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              creditWidgetListCard(
                  context,
                  5,
                  AppTheme.background,
                  "${answers.teamA != null || answers.teamA != "" ? answers.teamA : "--"}",
                  10.0,
                  FontWeight.w600,
                  Colors.black54),
              SizedBox(
                width: 5,
              ),
              creditWidgetListCard(
                  context,
                  5,
                  AppTheme.background,
                  "${answers.teamB != null || answers.teamB != "" ? answers.teamB : "--"}",
                  10.0,
                  FontWeight.w600,
                  Colors.black54),
              SizedBox(
                width: 5,
              ),
              creditWidgetListCard(
                  context,
                  5,
                  AppTheme.background,
                  "${answers.winner != null || answers.winner != "" ? answers.winner : "--"}",
                  10.0,
                  FontWeight.w600,
                  Colors.cyan),
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

  Widget creditWidgetListCard(
      BuildContext context,
      double cornerRadius,
      Color bgColor,
      String text,
      double fontSize,
      FontWeight fontWeight,
      Color textColor) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.all(
              Radius.circular(cornerRadius),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3),
          child: Center(
            child: Text(text,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: fontWeight)),
          ),
        ),
      ),
    );
  }

  Widget textDynamicWidget(BuildContext context, String text) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
          color: Colors.white
          //color: AppTheme.appDefaultColor2,
          ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 15,
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: AppTheme.appCardColor,
                    //color: AppTheme.appDefaultColor2,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      child: Text(
                        text.tr().toString(),
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                headingCard(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget headingCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.080,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
          Radius.circular(10),
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              creditWidgetTwo(
                  context,
                  10,
                  AppTheme.pieChartBackgroundColor1,
                  "Team A".tr().toString(),
                  15,
                  FontWeight.w900,
                  Colors.black54),

              creditWidgetTwo(
                  context,
                  10,
                  AppTheme.pieChartBackgroundColor1,
                  "Team B".tr().toString(),
                  15,
                  FontWeight.w900,
                  Colors.black54),
              creditWidgetTwo(
                  context,
                  10,
                  AppTheme.pieChartBackgroundColor1,
                  "Winner".tr().toString(),
                  15,
                  FontWeight.w900,
                  AppTheme.appDefaultColor),
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

  Widget creditWidgetTwo(
      BuildContext context,
      double cornerRadius,
      Color bgColor,
      String text,
      double fontSize,
      FontWeight fontWeight,
      Color textColor) {
    return Expanded(
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.070,
        decoration: BoxDecoration(
            // color: bgColor,
            // shape: BoxShape.circle,
            // borderRadius: BorderRadius.all(
            //   Radius.circular(cornerRadius),
            // )
            ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
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
      ),
    );
  }
}
