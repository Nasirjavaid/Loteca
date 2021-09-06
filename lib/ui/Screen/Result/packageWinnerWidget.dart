import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:locteca/ui/CommonWidget/circulerImageView.dart';

import '../../CommonWidget/circulerStaticImageView.dart';


class PackageWinnerWidget extends StatefulWidget {
  final dynamic packageWinners;

  PackageWinnerWidget({this.packageWinners});
  @override
  _PackageWinnerWidgetState createState() => _PackageWinnerWidgetState();
}

class _PackageWinnerWidgetState extends State<PackageWinnerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        textDynamicWidget(context, "First Jackpot Winners"),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.20,
            child: horizontalList(widget.packageWinners.firstJackPotWinners),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        textDynamicWidget(context, "Second Jackpot Winners"),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.20,
            child: horizontalList(widget.packageWinners.secondJackPotWinners),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        textDynamicWidget(context, "Third Jackpot Winners"),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.20,
            child: horizontalList(widget.packageWinners.thirdJackPotWinners),
          ),
        )
      ],
    ));
  }

  Widget horizontalList(jackpotWinners) {
    return jackpotWinners.length == 0 || jackpotWinners.length == null
        ? noItemsWidget(context)
        : ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount:
                jackpotWinners.length == 0 || jackpotWinners.length == null
                    ? 1
                    : jackpotWinners.length,
            padding: EdgeInsets.only(left: 8, right: 8),
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: jackpotWinners.length == 0 || jackpotWinners.length == null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "No Winners Found".tr().toString(),
                          ),
                        ),
                      ],
                    )
                  : winnerListItemCard(jackpotWinners[index]),
            ),
          );
  }

  Widget noItemsWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            CirculerStaticImageView(
                      height: 60,
                      width: 60,
                      imageUrl: 'assets/images/icon.png'),
           
            Center(
              child: Text("No Winners Found".tr().toString(),
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: AppTheme.appBackgroundColorforCard1,
                      fontSize: 10,
                      fontWeight: FontWeight.w900)),
            ),
          ],
        ),
      ),
    );
  }

  Widget winnerListItemCard(dynamic package) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 3,
      child: Container(
        height: 100,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.30,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CirculerImageView(
              height: 60,
              width: 60,
              imageUrl: package.image == null || package.image == ""
                  ? APIConstants.userImagePlaceHolder
                  : package.image,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
                package.name == null || package.name == ""
                    ? "N/A"
                    : package.name,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: AppTheme.appBackgroundColorforCard1,
                    fontSize: 12,
                    fontWeight: FontWeight.w900)),
            SizedBox(
              height: 10,
            ),
            creditWidget(context, Colors.amberAccent, package.winningCoins),
          ],
        ),
      ),
    );
  }

  Widget creditWidget(
      BuildContext context, Color backgroundColor, dynamic coins) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(FontAwesomeIcons.coins, size: 14, color: AppTheme.nearlyGold),
            SizedBox(
              width: 12,
            ),
            coins == null || coins == "N/A"
                ? Container()
                : Countup(
                    begin: 0,
                    end:
                        double.parse(coins) == null ? 0.0 : double.parse(coins),
                    duration: Duration(seconds: 3),
                    separator: ',',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: AppTheme.appDefaultColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w900)),
            // Text(coins == null ? "0" : "$coins",
            //     style: Theme.of(context).textTheme.bodyText2.copyWith(
            //         color: AppTheme.appDefaultColor,
            //         fontSize: 11,
            //         fontWeight: FontWeight.w900)),
          ],
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
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          //color: AppTheme.appDefaultColor2,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20),
          child: Text(text.tr().toString(),
              style: Theme.of(context).textTheme.button.copyWith(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w900)),
        ),
      ),
    );
  }
}
