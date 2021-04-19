import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/config/methods.dart';
import 'package:locteca/model/mainRound.dart';
import 'package:locteca/model/validateUser.dart';
import 'package:locteca/ui/Screen/MakeBet/printRecipt.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:async';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

class UserBetRecipt extends StatefulWidget {
  final MainRound mainRound;
  final ValidateUser validateUser;

  UserBetRecipt({this.mainRound, this.validateUser});

  @override
  _UserBetReciptState createState() => _UserBetReciptState();
}

class _UserBetReciptState extends State<UserBetRecipt> {
  ScreenshotController screenshotController = ScreenshotController();
  //define
  GlobalKey previewContainer = new GlobalKey();

  File _imageFile;
  int originalSize = 800;
  Image _image;
  final df = new DateFormat('dd-MM-yyyy ', 'en');
  final tf = new DateFormat('hh:mm a', 'en');

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 8,
      backgroundColor: Colors.transparent,
      child: buildChild(context),
    );
  }

  Widget buildChild(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: RepaintBoundary(
        key: previewContainer,
        child: Stack(
          children: [
            Container(
              height: widget.validateUser == null
                  ? MediaQuery.of(context).size.height * 0.90
                  : MediaQuery.of(context).size.height * 0.95,
              decoration: BoxDecoration(
                color: AppTheme.nearlyGold,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: [
                  Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 20.0),
                      //   child: Text(
                      //     "Loteca 2.0",
                      //     style: Theme.of(context)
                      //         .textTheme
                      //         .headline5
                      //         .copyWith(color: Colors.white),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Recipt".tr().toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: Colors.white, fontSize: 9),
                                ),
                                Text(
                                  "Date & time".tr().toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: Colors.white, fontSize: 9),
                                ),
                              ],
                            ),
                            Text(
                              "Loteca 2.0",
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .copyWith(color: Colors.white, fontSize: 16),
                            ),
                            Column(
                              children: [
                                Text(
                                  widget.mainRound.betDate == null
                                      ? " - - :- - : - - "
                                      : "${tf.format(DateTime.parse(widget.mainRound.betDate))}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: Colors.white, fontSize: 9),
                                ),
                                Text(
                                  widget.mainRound.betDate == null
                                      ? "-  - : -  - : - - - - "
                                      : "${df.format(DateTime.parse(widget.mainRound.betDate))}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: Colors.white, fontSize: 9),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                      decoration: BoxDecoration(
                          color: AppTheme.background1,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          widget.validateUser == null
                              ? userInformationWidget(
                                  widget.mainRound, widget.mainRound.user)
                              : userInformationWidget(
                                  widget.mainRound, widget.mainRound.agent),
                          SizedBox(
                            height: 5,
                          ),
                          widget.validateUser == null
                              ? Container()
                              : Column(
                                  children: [
                                    widget.validateUser.user.id !=
                                            widget.mainRound.agent.id
                                        ? validatedUserInformationWidget(
                                            widget.validateUser,
                                            widget.mainRound)
                                        : Container(),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                          roundInformationWidget(widget.mainRound),
                          SizedBox(
                            height: 5,
                          ),
                          textDynamicWidget(
                              context, "User Answers".tr().toString()),
                          selectedAnswersList(context, widget.mainRound),
                          // Spacer(),
                          // saveAndShareButton(context),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 110,
                  child: Column(
                    children: [
                      saveAndShareButton(context),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget roundInformationWidget(MainRound mainRound) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.background2,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          )),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Round Information".tr().toString(),
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Round name".tr().toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 10),
                ),
                Text(
                  widget.mainRound.round.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 11),
                ),
              ],
            ),
            // SizedBox(
            //   height: 4,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       "Total Packages".tr().toString(),
            //       style: Theme.of(context)
            //           .textTheme
            //           .bodyText1
            //           .copyWith(fontSize: 10),
            //     ),
            //     widget.mainRound.round.packages.length == 0
            //         ? Text("N/A")
            //         : Text(
            //             "0" + widget.mainRound.round.packages.length.toString(),
            //             style: Theme.of(context)
            //                 .textTheme
            //                 .bodyText2
            //                 .copyWith(fontSize: 11),
            //           ),
            //   ],
            // ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Games".tr().toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 10),
                ),
                widget.mainRound.round.games.length == 0
                    ? Text("N/A")
                    : Text(
                        "0" + widget.mainRound.round.games.length.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontSize: 11),
                      ),
              ],
            ),
            //widget.content,
          ],
        ),
      ),
    );
  }

  Widget userInformationWidget(MainRound mainRound, dynamic user) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.background2,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          )),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.validateUser == null
                  ? "User's Bet Information".tr().toString()
                  : "Bet Submitted By".tr().toString(),
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "User Name".tr().toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 10),
                ),
                Text(
                  user.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 11),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Email".tr().toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 10),
                ),
                Text(
                  user.email,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 11),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Selected Package".tr().toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 10),
                ),
                widget.mainRound.round.selectedPackage == null
                    ? Text("N/A")
                    : Text(
                        widget.mainRound.round.selectedPackage.participationFee,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontSize: 11),
                      ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Phone".tr().toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 10),
                ),
                user.phone == null
                    ? Text("N/A")
                    : Text(
                        user.phone,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontSize: 11),
                      ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       "Total available coins".tr().toString(),
            //       style: Theme.of(context)
            //           .textTheme
            //           .bodyText1
            //           .copyWith(fontSize: 10),
            //     ),
            //     Text(
            //       user.coins.toString(),
            //       style: Theme.of(context)
            //           .textTheme
            //           .bodyText2
            //           .copyWith(fontSize: 11),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget validatedUserInformationWidget(
      ValidateUser validateUser, MainRound mainRound) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.background2,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          )),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Bet Submitted for".tr().toString(),
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "User Name".tr().toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 10),
                ),
                Text(
                  validateUser.user.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 11),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Email".tr().toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 10),
                ),
                validateUser.user.email == ""
                    ? Text("0")
                    : Text(
                        validateUser.user.email,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontSize: 11),
                      ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "Phone".tr().toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 10),
              ),
              validateUser.user.phone == null
                  ? Text("N/A")
                  : Text(
                      validateUser.user.phone,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontSize: 11),
                    ),
            ]),
            SizedBox(
              height: 4,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       "Selected Package",
            //       style: Theme.of(context).textTheme.bodyText1,
            //     ),
            //     widget.mainRound.round.selectedPackage == null
            //         ? Text("N/A")
            //         : Text(
            //             widget.mainRound.round.selectedPackage.participationFee,
            //             style: Theme.of(context).textTheme.bodyText2,
            //           ),
            //   ],
            // ),
            // SizedBox(
            //   height: 4,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       "Total Available Coins".tr().toString(),
            //       style: Theme.of(context)
            //           .textTheme
            //           .bodyText1
            //           .copyWith(fontSize: 10),
            //     ),
            //     validateUser.user.coins == 0
            //         ? Text("0")
            //         : Text(
            //             validateUser.user.coins.toString(),
            //             style: Theme.of(context)
            //                 .textTheme
            //                 .bodyText2
            //                 .copyWith(fontSize: 11),
            //           ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget selectedAnswersList(BuildContext context, MainRound mainRound) {
    return Container(
      decoration: BoxDecoration(
          // color: AppTheme.background2,
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
        bottomLeft: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0),
      )),
      child: Column(
        children: [
          // SizedBox(
          //   height: 12,
          // ),
          // Text(
          //   "Selected Answers".tr().toString(),
          //   style: Theme.of(context).textTheme.bodyText2,
          // ),
          // SizedBox(
          //   height: 6,
          // ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.35,
              minHeight: MediaQuery.of(context).size.height * 0.30,
            ),
            child: ListView.builder(
              itemCount: mainRound.userAnswers.length,
              padding: EdgeInsets.all(8.0),
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return listWiewItemCard(
                  context,
                  mainRound.userAnswers[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget textDynamicWidget(BuildContext context, String text) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.white
          //color: AppTheme.appDefaultColor2,
          ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 5,
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
                          vertical: 5.0, horizontal: 10),
                      child: Text(
                        text.tr().toString(),
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(fontSize: 12, color: Colors.white),
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

  Widget listWiewItemCard(BuildContext context, UserAnswers answers) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              creditWidgetListCard(
                  context,
                  5,
                  AppTheme.background,
                  "${answers.teamA != null || answers.teamA != "" ? answers.teamA : "--"}",
                  9.0,
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
                  9.0,
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
                  9.0,
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
                  10,
                  FontWeight.w900,
                  Colors.black54),

              creditWidgetTwo(
                  context,
                  10,
                  AppTheme.pieChartBackgroundColor1,
                  "Team B".tr().toString(),
                  10,
                  FontWeight.w900,
                  Colors.black54),
              creditWidgetTwo(
                  context,
                  10,
                  AppTheme.pieChartBackgroundColor1,
                  "Selected".tr().toString(),
                  10,
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

  Widget saveAndShareButton(
    BuildContext context,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(
                      color: AppTheme.nearlyGold,
                    )),
                onPressed: () async {
                  dynamicFunctionForImageSaveAndShare(2);
                },
                color: AppTheme.nearlyGold,
                textColor: Colors.white,
                child: Icon(Icons.share_outlined, size: 18)),
            RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(
                      color: AppTheme.nearlyGold,
                    )),
                onPressed: () async {
                  dynamicFunctionForImageSaveAndShare(1);
                },
                color: AppTheme.nearlyGold,
                textColor: Colors.white,
                child: Icon(Icons.save, size: 18)),
            // RaisedButton(
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(18.0),
            //       side: BorderSide(
            //         color: AppTheme.nearlyGold,
            //       )),
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   color: AppTheme.nearlyGold,
            //   textColor: Colors.white,
            //   child: Text("Close".tr().toString(), style: TextStyle(fontSize: 14)),
            // ),

            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(
                    color: AppTheme.nearlyGold,
                  )),
              onPressed: () async {
                PrintRecipt printRecipt = PrintRecipt(widget.mainRound);
                await printRecipt.generateInvoice();
              },
              color: AppTheme.nearlyGold,
              textColor: Colors.white,
              child: Text("Print".tr().toString(), style: TextStyle(fontSize: 14)),
            ),
          ],
        ),
        RaisedButton(
          
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(
                color: AppTheme.nearlyRed,
              )),
          onPressed: () {
            Navigator.pop(context);
          },
          color: AppTheme.nearlyRed,
          textColor: Colors.white,
          child: Container(
            width: MediaQuery.of(context).size.width*0.69,
            child: Center(child: Text("Close".tr().toString(), style: TextStyle(fontSize: 14)))),
        ),
      ],
    );
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

  void dynamicFunctionForImageSaveAndShare(int requestCode) async {
    if (Platform.isAndroid) {
      await _handleCameraAndMic(Permission.storage);
    } else {
      await _handleCameraAndMic(Permission.photos);
    }
    var status;
    if (Platform.isAndroid) {
      status = await Permission.storage.status;
    } else {
      status = await Permission.photos.status;
    }
    // saveAnsShareImage(1, context);
    if (status == PermissionStatus.granted) {
      //Call function to open storage and save image file
      saveAnsShareImage(requestCode, context);
    } else if (status == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    } else {
      if (Platform.isAndroid) {
        await _handleCameraAndMic(Permission.storage);
      } else {
        await _handleCameraAndMic(Permission.photos);
      }
    }
  }

  void saveAnsShareImage(int requestCode, BuildContext context) async {
    if (requestCode == 1) {
      screenshotController.capture().then((File image) async {
        //Capture Done
        setState(() {
          _imageFile = image;
        });

        final result = await ImageGallerySaver.saveImage(
            _imageFile.readAsBytesSync(),
            quality: 100);
        print("File Saved to Gallery $result");
        Methods.showInfoFlushbarHelper(
          context,
          "Recipt".tr().toString(),
          "Recipt successfully saved".tr().toString(),
        );
      }).catchError((onError) {
        print(onError);
      });

      // print("Image file here ${result}");
    } else if (requestCode == 2) {
      // share(result);
      ShareFilesAndScreenshotWidgets().shareScreenshot(
        previewContainer,
        originalSize,
        "Loteca 2.0 Bet Recipt",
        "MyRecipt.png",
        "image/png",
        text: "My Recipt".tr().toString(),
      );
    }
  }
}

class DialogHelper {
  static exit(context) =>
      showDialog(context: context, builder: (context) => UserBetRecipt());
}
