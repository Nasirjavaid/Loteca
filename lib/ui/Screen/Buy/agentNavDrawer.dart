import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locteca/bloc/userAuthBloc/userAuthBloc.dart';
import 'package:locteca/bloc/userAuthBloc/userAuthEvent.dart';
import 'package:locteca/bloc/userProfileBloc/userProfileBloc.dart';
import 'package:locteca/bloc/userProfileBloc/userProfileEvent.dart';
import 'package:locteca/bloc/userProfileBloc/userProfileState.dart';
import 'package:locteca/ui/Screen/Buy/agentDetailScreen.dart';
import 'package:locteca/ui/Screen/GeneralRanking/generalRanking.dart';
import 'package:locteca/model/userLogin.dart';
import 'package:locteca/repository/userAuthRepository.dart';
import 'package:locteca/ui/CommonWidget/commonWidgets.dart';
import 'package:locteca/ui/Screen/DashboardScreen/myNavDrawerItems.dart';

class AgentNavDrawerMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) {
          return UserProfileBloc()..add(GetUserDataUserProfileEvent());
        },
        child: AgentNavDrawer(context),
      ),
    );
  }
}

class AgentNavDrawer extends StatefulWidget {
  final BuildContext context;
  AgentNavDrawer(this.context);

  @override
  _AgentNavDrawerState createState() => _AgentNavDrawerState();
}

class _AgentNavDrawerState extends State<AgentNavDrawer> {
  final UserAuthRepository userAuthRepository = UserAuthRepository();

  bool guestUserValue = false;
  String userImagePlaceHolder =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/768px-Circle-icons-profile.svg.png";

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
              // SizedBox(
              //   height: 0,
              // ),
              // new MyDrawerItems(context).drawerItem(
              //     icon: FontAwesomeIcons.user,
              //     text: 'Profile',
              //     onTap: () => {
              //           //clossing the nav drawer after click
              //           Navigator.pop(context),

              //           //   Navigator.push(
              //           //     context,
              //           //     MaterialPageRoute(
              //           //       builder: (context) => UserProfileScreen(),
              //           //     ),
              //           //   ),
              //         }),
              // Divider(),
              // SizedBox(
              //   height: 0,
              // ),
              // new MyDrawerItems(context).drawerItem(
              //     icon: FontAwesomeIcons.list,
              //     text: 'Feedback',
              //     onTap: () => {
              //           //clossing the nav drawer after click
              //           Navigator.pop(context),

              //           // Navigator.push(
              //           //   context,
              //           //   MaterialPageRoute(
              //           //     builder: (context) => MyOrdersScreen(),
              //           //   ),
              //           // ),
              //         }),
              // Divider(),
              // SizedBox(
              //   height: 0,
              // ),
              // SizedBox(
              //   height: 0,
              // ),
              // new MyDrawerItems(context).drawerItem(
              //     icon: FontAwesomeIcons.addressBook,
              //     text: 'About us',
              //     onTap: () => {
              //           // Navigator.pop(context),
              //           // BlocProvider.of<CartBloc>(context)
              //           //     .add(SaveDataToSharedPrefrencesCartEvent()),
              //           // NetworkConnectivity.check().then((internet) {
              //           //   if (internet) {
              //           //     Navigator.push(
              //           //       context,
              //           //       MaterialPageRoute(
              //           //         builder: (context) => WebViewContainer(
              //           //             "https://unique-itsolutions.co.uk/restaurant-demo/new/about",
              //           //             "About us"),
              //           //       ),
              //           //     );
              //           //   } else {
              //           //     //show network erro

              //           //     Methods.showToast(context, "Check your network");
              //           //   }
              //           // }),
              //           //clossing the nav drawer after click
              //         }),
              // Divider(),
              // SizedBox(
              //   height: 0,
              // ),
              // new MyDrawerItems(context).drawerItem(
              //     icon: FontAwesomeIcons.mailBulk,
              //     text: 'Contact us',
              //     onTap: () => {
              //           //clossing the nav drawer after click
              //           Navigator.pop(context),
              //           // BlocProvider.of<CartBloc>(context)
              //           //     .add(SaveDataToSharedPrefrencesCartEvent()),

              //           // NetworkConnectivity.check().then((internet) {
              //           //   if (internet) {
              //           //     Navigator.push(
              //           //       context,
              //           //       MaterialPageRoute(
              //           //         builder: (context) => WebViewContainer(
              //           //             "https://unique-itsolutions.co.uk/restaurant-demo/new/contact",
              //           //             "Contact us"),
              //           //       ),
              //           //     );
              //           //   } else {
              //           //     //show network erro

              //           //     Methods.showToast(context, "Check your network");
              //           //   }
              //           // }),
              //         }),
              // Divider(),
              // SizedBox(
              //   height: 0,
              // ),
              Builder(
                builder: (
                  BuildContext context,
                ) {
                  return MyDrawerItems(context).drawerItem(
                      icon: FontAwesomeIcons.powerOff,
                      text: 'Logout',
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
              //),
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
                  child: Avatar(
                    circleText: "",
                    circleShow: false,
                    circleColor: Colors.green,
                    circleHeight: 22,
                    circleWidth: 22,
                    height: 75,
                    width: 75,
                    imageUrl:
                        "https://fastly.syfy.com/sites/syfy/files/styles/1170xauto/public/dummy-murdock1.jpg",
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
                      color: Colors.black45, fontWeight: FontWeight.w900,fontSize:18,inherit: true),
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
