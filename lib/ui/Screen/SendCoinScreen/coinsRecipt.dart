import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/config/methods.dart';
import 'package:locteca/main.dart';
import 'package:locteca/model/mainRound.dart';
import 'package:locteca/model/sendCoin.dart';
import 'package:locteca/model/validateUser.dart';
import 'package:locteca/repository/userAuthRepository.dart';
import 'package:locteca/ui/Screen/SendCoinScreen/printCoinRecipt.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:async';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

class CoinRecipt extends StatefulWidget {
  final SendCoin sendCoin;
  final int apiDirectionalCall;

  CoinRecipt({this.sendCoin, this.apiDirectionalCall});

  @override
  _CoinReciptState createState() => _CoinReciptState();
}

class _CoinReciptState extends State<CoinRecipt> {
  ScreenshotController screenshotController = ScreenshotController();
  //define
  GlobalKey previewContainer = new GlobalKey();
  final userRepository = UserAuthRepository();

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
              height: MediaQuery.of(context).size.height * 0.55,
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
                                  widget.sendCoin.coinsTransferDate == null
                                      ? " - - :- - : - - "
                                      : "${tf.format(DateTime.parse(widget.sendCoin.coinsTransferDate))}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: Colors.white, fontSize: 9),
                                ),
                                Text(
                                  widget.sendCoin.coinsTransferDate == null
                                      ? "-  - : -  - : - - - - "
                                      : "${df.format(DateTime.parse(widget.sendCoin.coinsTransferDate))}",
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
                          transferCoinsWidget(widget.sendCoin),
                          SizedBox(
                            height: 5,
                          ),
                          userInformationWidget(
                            widget.sendCoin.user,
                            "Coins sent to".tr().toString(),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          userInformationWidget(
                            widget.sendCoin.agent,
                            "Coins sent by".tr().toString(),
                          ),
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
                  height: widget.apiDirectionalCall == 1 ||
                          widget.apiDirectionalCall == 2
                      ? 55
                      : 110,
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

  Widget transferCoinsWidget(SendCoin sendCoin) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.background2,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          )),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Successfully Transfered".tr().toString(),
              style:
                  Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  sendCoin.coinsTransferred != null
                      ? sendCoin.coinsTransferred.toString()
                      : "--",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "Coin(s)".tr().toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 9),
                ),
                // Icon(FontAwesomeIcons.coins,size: 12,color: AppTheme.nearlyGold,)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget userInformationWidget(dynamic user, String headingText) {
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
              headingText,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  user.roles == "1"
                      ? "User Name".tr().toString()
                      : "Agent Name".tr().toString(),
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
                  "Phone".tr().toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 10),
                ),
                Text(
                  user.phone.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 11),
                ),
              ],
            ),
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
                  "Agent Name".tr().toString(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Available Coins".tr().toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 10),
                ),
                validateUser.user.coins == 0
                    ? Text("0")
                    : Text(
                        validateUser.user.coins.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontSize: 11),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget selectedAnswersList(BuildContext context, MainRound mainRound) {
  //   return Container(
  //     decoration: BoxDecoration(
  //         color: AppTheme.background2,
  //         borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(15.0),
  //           topRight: Radius.circular(15.0),
  //           bottomLeft: Radius.circular(20.0),
  //           bottomRight: Radius.circular(20.0),
  //         )),
  //     child: Column(
  //       children: [
  //         SizedBox(
  //           height: 12,
  //         ),
  //         Text(
  //           "Selected Answers".tr().toString(),
  //           style: Theme.of(context).textTheme.bodyText2,
  //         ),
  //         SizedBox(
  //           height: 6,
  //         ),
  //         ConstrainedBox(
  //           constraints: BoxConstraints(
  //             maxHeight: MediaQuery.of(context).size.height * 0.25,
  //             minHeight: MediaQuery.of(context).size.height * 0.20,
  //           ),
  //           child: GridView.builder(
  //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //               crossAxisCount: 2,
  //               childAspectRatio: 10.0 / 3.5,
  //             ),
  //             itemCount: mainRound.userAnswers.reversed.length,
  //             padding: EdgeInsets.all(8.0),
  //             physics: BouncingScrollPhysics(),
  //             itemBuilder: (BuildContext context, int index) {
  //               return itemCardOfList(context, mainRound, index);
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget itemCardOfList(BuildContext context, MainRound mainRound, int index) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 2.0, right: 2),
  //     child: Container(
  //         decoration: BoxDecoration(
  //             color: AppTheme.background3,
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(20.0),
  //               topRight: Radius.circular(20.0),
  //               bottomLeft: Radius.circular(20.0),
  //               bottomRight: Radius.circular(20.0),
  //             )),
  //         child: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Row(
  //             children: [
  //               Icon(
  //                 Icons.flag,
  //                 size: 16,
  //                 color: Colors.black38,
  //               ),
  //               SizedBox(
  //                 width: 5,
  //               ),
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       mainRound.userAnswers[index].gameId == null
  //                           ? "--"
  //                           : "Game ID# : " +
  //                               mainRound.userAnswers[index].gameId.toString(),
  //                       maxLines: 2,
  //                       overflow: TextOverflow.ellipsis,
  //                       style: Theme.of(context).textTheme.bodyText1.copyWith(
  //                           color: Colors.black38,
  //                           fontWeight: FontWeight.w500,
  //                           fontSize: 9),
  //                     ),
  //                     SizedBox(
  //                       height: 2,
  //                     ),
  //                     Expanded(
  //                         child: Text(
  //                       mainRound.userAnswers[index].answer == null
  //                           ? "--"
  //                           : mainRound.userAnswers[index].answer,
  //                       maxLines: 2,
  //                       overflow: TextOverflow.ellipsis,
  //                       style: Theme.of(context).textTheme.bodyText1.copyWith(
  //                           color: Colors.black45,
  //                           fontWeight: FontWeight.w700,
  //                           fontSize: 9),
  //                     )),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         )),
  //   );
  // }

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
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(
                    color: AppTheme.nearlyGold,
                  )),
              onPressed: () async {
                PrintCoinRecipt printRecipt = PrintCoinRecipt(widget.sendCoin);
                await printRecipt.generateInvoice();
              },
              color: AppTheme.nearlyGold,
              textColor: Colors.white,
              child:
                  Text("Print".tr().toString(), style: TextStyle(fontSize: 14)),
            ),
          ],
        ),
        widget.apiDirectionalCall == 1 || widget.apiDirectionalCall == 2
            ? Container()
            : RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(
                      color: AppTheme.nearlyGold,
                    )),
                onPressed: () {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    // add your code here.

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => App(
                                userRepository: userRepository,
                              )),
                    );
                  });
                },
                color: AppTheme.nearlyRed,
                textColor: Colors.white,
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.69,
                    child: Center(
                        child: Text("Close".tr().toString(),
                            style: TextStyle(fontSize: 14)))),
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

// class DialogHelper {
//   static exit(context) =>
//       showDialog(context: context, builder: (context) => CoinRecipt());
// }
