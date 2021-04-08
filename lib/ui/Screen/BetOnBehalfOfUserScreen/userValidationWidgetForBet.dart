import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locteca/bloc/sendCoinBloc/sendCoinBloc.dart';
import 'package:locteca/bloc/sendCoinBloc/sendCoinEvent.dart';
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/config/methods.dart';
import 'package:locteca/config/networkConnectivity.dart';
import 'package:locteca/model/validateUser.dart';
import 'package:locteca/ui/Screen/BetOnBehalfOfUserScreen/agentBetScreen.dart';
import 'package:locteca/ui/Screen/GeneralRanking/generalRanking.dart';
import 'package:easy_localization/easy_localization.dart';

class UserValidationWidgetForBet extends StatefulWidget {
  final ValidateUser validateUser;

  UserValidationWidgetForBet({this.validateUser});
  @override
  UserValidationWidgetForBetState createState() =>
      UserValidationWidgetForBetState();
}

class UserValidationWidgetForBetState
    extends State<UserValidationWidgetForBet> {
  final ValidateUser validateUser;
  UserValidationWidgetForBetState({this.validateUser});
  submitButtonPressed(String coins, BuildContext context, String email) {
    if (coins == null || coins.isEmpty) {
      Methods.showToast(context, "Please Enter Coins".tr().toString());
    } else {
      BlocProvider.of<SendCoinBloc>(context).add(
        SendCoinsToUserEvent(email: email, coins: coins),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(widget.validateUser, context);
  }

  Widget _buildBody(ValidateUser userLogin, BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              // Container(height:MediaQuery.of(context).size.height * 0.20),
              //topClipper(context),
            ],
          ),
          Column(
            children: <Widget>[
              ProfileHeader(
                imageUrl: userLogin.user.images[0].url == null ||
                        userLogin.user.images[0].url == ""
                    ? APIConstants.userImagePlaceHolder
                    : userLogin.user.images[0].url,
                backgroundImageUrl: userLogin.user.images[0].url == null ||
                        userLogin.user.images[0].url == ""
                    ? APIConstants.userImagePlaceHolder
                    : userLogin.user.images[0].url,
                title: userLogin.user.name == null || userLogin.user.name == ""
                    ? "N/A"
                    : userLogin.user.name,

                subtitle:
                    userLogin.user.email == null || userLogin.user.email == ""
                        ? "N/A"
                        : userLogin.user.email,
                // actions: <Widget>[
                //   MaterialButton(
                //     color: Colors.blue,
                //     shape: CircleBorder(),
                //     elevation: 0,
                //     child: Icon(Icons.edit,color: Colors.white,),
                //     onPressed: () {},
                //   )
                //],
              ),
              const SizedBox(height: 10.0),
              UserInfo(
                userLogin: userLogin,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget topClipper(BuildContext context) {
//return Text("FORGOT PASSWORD?", style:  GoogleFonts.lato());
    return Stack(children: [
      ClipPath(
        clipper: OvalBottomBorderClipper(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.20,
          color: AppTheme.appDefaultColor,
          child: Center(child: Text("")),
        ),
      ),
      ClipPath(
        clipper: WaveClipperTwo(reverse: false),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.37,
          color: Colors.blue[900].withOpacity(0.1),
          child: Center(child: Text("")),
        ),
      ),
      ClipPath(
        clipper: WaveClipperOne(reverse: false),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.92,
          color: Colors.blue[600].withOpacity(0.1),
          child: Center(child: Text("")),
        ),
      ),
    ]);
  }

  Widget bottomClipper(BuildContext context) {
//return Text("FORGOT PASSWORD?", style:  GoogleFonts.lato());
    return Stack(children: [
      ClipPath(
        clipper: OvalTopBorderClipper(),
        child: Container(
          height: 100,
          color: Colors.blue[100].withOpacity(0.5),
          child: Center(child: Text("")),
        ),
      ),
      ClipPath(
        clipper: WaveClipperTwo(reverse: true),
        child: Container(
          height: 100,
          color: Colors.blue[900].withOpacity(0.1),
          child: Center(child: Text("")),
        ),
      ),
      ClipPath(
        clipper: WaveClipperOne(reverse: true),
        child: Container(
          height: 100,
          color: Colors.blue[600].withOpacity(0.1),
          child: Center(child: Text("")),
        ),
      ),
    ]);
  }
}

class UserInfo extends StatelessWidget {
  UserInfo({@required this.userLogin});

  final ValidateUser userLogin;

  final TextEditingController etCoins = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 25),
      child: Card(
        elevation: 16,
        color: Colors.white.withOpacity(0.90),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            children: [
              Container(
                // padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              "User Information".tr().toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .copyWith(fontSize: 18),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              ...ListTile.divideTiles(
                                color: Colors.grey,
                                tiles: [
                                  ListTile(
                                    dense: true,
                                    leading: Icon(
                                      FontAwesomeIcons.anchor,
                                      color:
                                          AppTheme.appBackgroundColorforCard2,
                                    ),
                                    title: Text(
                                      "Role".tr().toString(),
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                    subtitle: userLogin.user.roles == null ||
                                            userLogin.user.roles == ""
                                        ? Text("N/A")
                                        : Text(
                                            "Available as".tr().toString()+" ${userLogin.user.roles == "1" ? "'Player'" : "'Agent'"}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .copyWith(fontSize: 12),
                                          ),
                                  ),
                                  // ListTile(
                                  //   dense: true,
                                  //   leading: Icon(
                                  //     FontAwesomeIcons.coins,
                                  //     color: AppTheme.nearlyGold,
                                  //   ),
                                  //   title: Text(
                                  //     "Coins",
                                  //     style: Theme.of(context).textTheme.button,
                                  //   ),
                                  //   subtitle: userLogin.user.coins == null ||
                                  //           userLogin.user.coins == ""
                                  //       ? Text("N/A")
                                  //       : Text(
                                  //           "Total Coins : ${userLogin.user.coins}",
                                  //           style: Theme.of(context)
                                  //               .textTheme
                                  //               .bodyText1
                                  //               .copyWith(fontSize: 12),
                                  //         ),
                                  // ),
                                  ListTile(
                                    dense: true,
                                    leading: Icon(
                                      Icons.email,
                                      color: Colors.redAccent,
                                    ),
                                    title: Text(
                                      "Email".tr().toString(),
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                    subtitle: userLogin.user.email == null ||
                                            userLogin.user.email == ""
                                        ? Text("N/A")
                                        : Text(
                                            "${userLogin.user.email}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .copyWith(fontSize: 12),
                                          ),
                                  ),
                                  ListTile(
                                      dense: true,
                                      leading: Icon(
                                        Icons.phone,
                                        color: Colors.blue,
                                      ),
                                      title: Text(
                                        "Phone".tr().toString(),
                                        style:
                                            Theme.of(context).textTheme.button,
                                      ),
                                      subtitle:
                                          userLogin.user.contacts[0].phone ==
                                                      null ||
                                                  userLogin.user.contacts[0]
                                                          .phone ==
                                                      ""
                                              ? Text("N/A")
                                              : Text(
                                                  "${userLogin.user.contacts[0].phone}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1
                                                      .copyWith(fontSize: 12),
                                                )),
                                  ListTile(
                                      dense: true,
                                      leading: Icon(FontAwesomeIcons.whatsapp,
                                          color: Colors.cyan),
                                      title: Text(
                                        "WhatsApp".tr().toString(),
                                        style:
                                            Theme.of(context).textTheme.button,
                                      ),
                                      subtitle:
                                          userLogin.user.contacts[0].whatsapp ==
                                                      null ||
                                                  userLogin.user.contacts[0]
                                                          .whatsapp ==
                                                      ""
                                              ? Text("N/A")
                                              : Text(
                                                  "${userLogin.user.contacts[0].whatsapp}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1
                                                      .copyWith(fontSize: 12),
                                                )),

                                  dataInputAndSubmitFields(
                                      context, userLogin.user.email,userLogin),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dataInputAndSubmitFields(BuildContext context, String email,ValidateUser validateUser) {
    return Column(children: [
      SizedBox(
        height: 20,
      ),
      SizedBox(
        height: 20,
      ),
      subMitButton(context, email,validateUser)
    ]);
  }

  Widget enterCoinsInputField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.06,
      child: new TextField(
          controller: etCoins,
          expands: false,
          maxLines: 1,
          minLines: 1,
          keyboardType: TextInputType.number,
          autocorrect: false,

          //validator: _validateFirstName,

          decoration: InputDecoration(
            prefixIcon:
                Icon(FontAwesomeIcons.coins, color: AppTheme.nearlyGold),
            counterText: "",
            // filled: true,
            // fillColor: AppTheme.appDefaultColor,
            labelText: "Enter Coins",
            labelStyle:
                TextStyle(color: AppTheme.appDefaultColor, fontSize: 12),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: AppTheme.appDefaultColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: AppTheme.appDefaultColor,
                width: 1.0,
              ),
            ),
          )),
    );
  }

  Widget subMitButton(BuildContext context, String email,ValidateUser validateUser) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width * 0.30,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: Container(
              // margin: EdgeInsets.only(top: 0.0),
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                gradient: new LinearGradient(
                    colors: [AppTheme.appCardColor, AppTheme.appCardColor],
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 12.0),

//checking user before placing the order
                    // child: guestUserValue
                    //     ? Text("Sign In",
                    //         style: Theme.of(context).textTheme.bodyText2.copyWith(
                    //             fontWeight: FontWeight.w600, color: Colors.white))
                    //     : Text("Check out",
                    //         style: Theme.of(context).textTheme.bodyText2.copyWith(
                    //             fontWeight: FontWeight.w600, color: Colors.white)),

                    child: Text("Back".tr().toString(),
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                  onPressed: () async {
                    // print("check availability button pressed");

                    BlocProvider.of<SendCoinBloc>(context)
                        .add(ShowUserValidationFormForBetEvent());
                  }),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width * 0.30,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: Container(
              // margin: EdgeInsets.only(top: 0.0),
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                gradient: new LinearGradient(
                    colors: [AppTheme.appCardColor, AppTheme.appCardColor],
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 12.0),

//checking user before placing the order
                    // child: guestUserValue
                    //     ? Text("Sign In",
                    //         style: Theme.of(context).textTheme.bodyText2.copyWith(
                    //             fontWeight: FontWeight.w600, color: Colors.white))
                    //     : Text("Check out",
                    //         style: Theme.of(context).textTheme.bodyText2.copyWith(
                    //             fontWeight: FontWeight.w600, color: Colors.white)),

                    child: Text("Go ahead".tr().toString(),
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                  onPressed: () async {
                    // print("check availability button pressed");

                    NetworkConnectivity.check().then((internet) {
                      if (internet) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AgentBetScreenMain(validateUser:validateUser,bottomSheetcontextFlag:1),
                            ),
                          );
                      } else {
                        //show network erro

                        Methods.showToast(context, "Check your network".tr().toString());
                      }
                    });
                  }),
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader(
      {Key key,
      this.backgroundImageUrl,
      @required this.imageUrl,
      @required this.title,
      this.subtitle,
      this.actions})
      : super(key: key);

  final List<Widget> actions;
  final String backgroundImageUrl;
  final String imageUrl;
  final String subtitle;
  final String title;

  @override
  Widget build(BuildContext context) {
    double dynamicPadding = MediaQuery.of(context).size.height * 0.050;
    return Stack(
      children: <Widget>[
        // RoundedCornerImageViewWithoutBorderDynamic(
        //   width: MediaQuery.of(context).size.width,
        //   height: MediaQuery.of(context).size.height * 0.25,
        //   imageLink: backgroundImageUrl,
        //   borderWidth: 0,
        //   cornerRadius: 0,
        // ),
        // Ink(
        //   height: 200,
        //   decoration: BoxDecoration(
        //     image: DecorationImage(image: backgroundImageUrl, fit: BoxFit.cover),
        //   ),
        // ),
        // Ink(
        //   height: MediaQuery.of(context).size.height * 0.25,
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //   ),
        //),
        if (actions != null)
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.35,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: dynamicPadding),
          child: Column(
            children: <Widget>[
              Avatar(
                height: 70,
                width: 70,
                circleShow: true,
                circleTextWidget: Container(),
                imageUrl: imageUrl,
                radius: 40,
                backgroundColor: Colors.white,
                borderColor: Colors.black,
                borderWidth: 10.0,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headline6,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 5.0),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ]
            ],
          ),
        )
      ],
    );
  }
}
