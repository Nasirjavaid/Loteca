import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locteca/bloc/userAuthBloc/userAuthBloc.dart';
import 'package:locteca/bloc/userAuthBloc/userAuthEvent.dart';
import 'package:locteca/bloc/userProfileBloc/userProfileBloc.dart';
import 'package:locteca/bloc/userProfileBloc/userProfileEvent.dart';
import 'package:locteca/bloc/userProfileBloc/userProfileState.dart';
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/config/methods.dart';
import 'package:locteca/config/networkConnectivity.dart';
import 'package:locteca/ui/Screen/AboutScreen/aboutScreen.dart';
import 'package:locteca/ui/Screen/CoinRecordScreen/userCoinRecordScreen.dart';
import 'package:locteca/ui/Screen/ContactUsScreen/contactUsScreen.dart';


import 'package:locteca/ui/Screen/FeedBackScreen/feedBackScreen.dart';
import 'package:locteca/ui/Screen/GeneralRanking/generalRanking.dart'
    as newAvater;
import 'package:locteca/model/userLogin.dart';
import 'package:locteca/repository/userAuthRepository.dart';
import 'package:locteca/ui/CommonWidget/commonWidgets.dart';
import 'package:locteca/ui/Screen/DashboardScreen/myNavDrawerItems.dart';
import 'package:locteca/ui/Screen/MakeBet/makeBet.dart';
import 'package:locteca/ui/Screen/UserProfileScreen/userProfileScreen.dart';
import 'package:easy_localization/easy_localization.dart';

class MyNaveDrawerMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) {
          return UserProfileBloc()..add(GetUserDataUserProfileEvent());
        },
        child: MyNavDrawer(context),
      ),
    );
  }
}

class MyNavDrawer extends StatefulWidget {
  final BuildContext context;
  MyNavDrawer(this.context);

  @override
  _MyNavDrawerState createState() => _MyNavDrawerState();
}

class _MyNavDrawerState extends State<MyNavDrawer> {
  final UserAuthRepository userAuthRepository = UserAuthRepository();

  bool guestUserValue = false;

  @override
  void initState() {
    getValueOFguestUserFromSharedPrefrences();
    super.initState();
  }

  getValueOFguestUserFromSharedPrefrences() async {
    // guestUserValue = await Methods.getGuestFromSharedPref();
    setState(() {
      return guestUserValue;
    });

    return guestUserValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(0), topRight: Radius.circular(0)),
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(color: Colors.green, spreadRadius: 3),
        // ],
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.75,
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.

      child: Column(
        // Important: Remove any padding from the ListView
        // padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: 0),
          // rawer header
          DrawerHeader(child: BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (BuildContext context, state) {
              UserLogin userLoginFailure = UserLogin();
              if (state is InProgresssGettingUserProfileState) {
                return CommonWidgets.progressIndicator;
              }
              if (state is UserProfiledetailTakenSuccessfully) {
                return userInfoWidget(state.userLogin);
              }

              if (state is FailedTogetUserProfileData) {
                return Center(child: userInfoWidget(userLoginFailure));
              }

              return Container();
            },
          )),

          SingleChildScrollView(
            //  height: MediaQuery.of(context).size.height,
            // color: Colors.transparent,
            child: Column(children: [
              SizedBox(
                height: 0,
              ),
              new MyDrawerItems(context).drawerItem(
                  icon: FontAwesomeIcons.user,
                  colorData: Colors.blue,
                  text: 'My Profile'.tr().toString(),
                  onTap: () => {
                        //clossing the nav drawer after click
                        Navigator.pop(context),

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfileScreen(),
                          ),
                        ),
                      }),
              Divider(),
              new MyDrawerItems(context).drawerItem(
                  icon: FontAwesomeIcons.coins,
                  colorData: AppTheme.nearlyGold,
                  text: 'Coin History'.tr().toString(),
                  onTap: () => {
                        //clossing the nav drawer after click
                        Navigator.pop(context),

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserCoinRecordScreenMain(),
                          ),
                        ),
                      }),
              // Divider(),
              // SizedBox(
              //   height: 0,
              // ),
              //  Divider(),
              // new MyDrawerItems(context).drawerItem(
              //     icon: FontAwesomeIcons.coins,
              //     colorData: AppTheme.nearlyGold,
              //     text: 'Make Bet'.tr().toString(),
              //     onTap: () => {
              //           //clossing the nav drawer after click
              //           Navigator.pop(context),

              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => MakeBetMain(0),
              //             ),
              //           ),
              //         }),
              Divider(),
              SizedBox(
                height: 0,
              ),

              new MyDrawerItems(context).drawerItem(
                  icon: FontAwesomeIcons.list,
                  colorData: Colors.green,
                  text: 'Feedback'.tr().toString(),
                  onTap: () => {
                        Navigator.pop(context),
                        NetworkConnectivity.check().then((internet) {
                          if (internet) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FeedBackScreen()),
                            );
                          } else {
                            //show network erro

                            Methods.showToast(context, "Check your network".tr().toString(),);
                          }
                        }),
                      }),
              Divider(),
              SizedBox(
                height: 0,
              ),
              SizedBox(
                height: 0,
              ),
              new MyDrawerItems(context).drawerItem(
                  icon: FontAwesomeIcons.addressBook,
                  colorData: Colors.indigo,
                  text: 'About Us'.tr().toString(),
                  onTap: () => {
                        Navigator.pop(context),
                        NetworkConnectivity.check().then((internet) {
                          if (internet) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutScreen()),
                            );
                          } else {
                            //show network erro

                            Methods.showToast(context, "Check your network".tr().toString(),);
                          }
                        }),
                      }),
              Divider(),
              SizedBox(
                height: 0,
              ),
              new MyDrawerItems(context).drawerItem(
                  icon: FontAwesomeIcons.mailBulk,
                  colorData: Colors.cyan,
                  text: 'Contact Us'.tr().toString(),
                  onTap: () => {
                        //clossing the nav drawer after click
                        Navigator.pop(context),
                        // BlocProvider.of<CartBloc>(context)
                        //     .add(SaveDataToSharedPrefrencesCartEvent()),

                        NetworkConnectivity.check().then((internet) {
                          if (internet) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContactUsScreen(),
                              ),
                            );
                          } else {
                            //show network erro

                            Methods.showToast(context, "Check your network".tr().toString(),);
                          }
                        }),
                      }),
              Divider(),
              SizedBox(
                height: 0,
              ),
              Builder(
                builder: (
                  BuildContext context,
                ) {
                  return MyDrawerItems(context).drawerItem(
                      icon: FontAwesomeIcons.powerOff,
                      colorData: Colors.red,
                      text: 'Logout'.tr().toString(),
                      onTap: () {
                        BlocProvider.of<UserAuthBloc>(context)
                            .add(AuthLoggedOut());
                      });
                },
              ),
              Divider(),
              // new MyDrawerItems(context).drawerItem(
              //     icon: FontAwesomeIcons.user,
              //     text: 'Aegent Profile View',
              //     onTap: () => {
              //           //clossing the nav drawer after click
              //           Navigator.pop(context),

              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => AgentDetailScreen(),
              //             ),
              //           ),
              //         }),
              // Divider(),
              // SizedBox(
              //   height: 0,
              // ),
            ]),
          )
        ],
      ),
    );
  }

  Widget userInfoWidget(UserLogin userLogin) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Stack(children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment(0, -0.5),
            child: Column(
              children: [
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    //borderRadius: BorderRadius.all(Radius.circular(25)),
                    shape: BoxShape.circle,
                  ),
                  child: newAvater.Avatar(
                    circleTextWidget: Container(),
                    circleShow: false,
                    circleColor: Colors.green,
                    circleHeight: 22,
                    circleWidth: 22,
                    height: 75,
                    width: 75,
                    imageUrl: userLogin.data.user.images[0].url == "" ||
                            userLogin.data.user.images[0].url == null
                        ? APIConstants.userImagePlaceHolder
                        : userLogin.data.user.images[0].url,
                    radius: 40,
                    backgroundColor: Colors.white,
                    borderColor: Colors.grey.shade300,
                    borderWidth: 4.0,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  userLogin.data.user.name == null ||
                          userLogin.data.user.name == ""
                      ? "N/A"
                      : userLogin.data.user.name,
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      inherit: true),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  userLogin.data.user.email == null ||
                          userLogin.data.user.email == ""
                      ? "N/A"
                      : userLogin.data.user.email,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
        )
      ]),
      // SizedBox(height: 5),
      // Text(
      //     "Guest",
      //     style: Theme.of(context)
      //         .textTheme
      //         .bodyText2
      //         .copyWith(color: Colors.black87, fontWeight: FontWeight.w600)),
    );
  }
}
