import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locteca/bloc/userAuthBloc/userAuthBloc.dart';
import 'package:locteca/bloc/userAuthBloc/userAuthEvent.dart';
import 'package:locteca/bloc/userProfileBloc/userProfileBloc.dart';
import 'package:locteca/bloc/userProfileBloc/userProfileEvent.dart';
import 'package:locteca/bloc/userProfileBloc/userProfileState.dart';
import 'package:locteca/config/appConstants.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/main.dart';
import 'package:locteca/model/userLogin.dart';
import 'package:locteca/repository/userAuthRepository.dart';
import 'package:locteca/ui/CommonWidget/circulerImageView.dart';
import 'package:locteca/ui/CommonWidget/commonWidgets.dart';
import 'package:meta/meta.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) {
          return UserProfileBloc()..add(GetUserDataUserProfileEvent());
        },
        child: UserProfiletPage(),
      ),
    );
  }
}

class UserProfiletPage extends StatefulWidget {
  UserProfiletPage({this.realoadMe});

  final bool realoadMe;

  @override
  _UserProfiletPageState createState() => _UserProfiletPageState();
}

class _UserProfiletPageState extends State<UserProfiletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: AppTheme.background,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white38),
           title: Text(
          "My Profile",
          style: Theme.of(context).textTheme.button.copyWith(
              color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w700),
        ),),
        body: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (BuildContext context, state) {
            if (state is InProgresssGettingUserProfileState) {
              return CommonWidgets.progressIndicator;
            }
            if (state is UserProfiledetailTakenSuccessfully) {
              //TODO: Uncomment this block
              // BlocProvider.of<UserProfileBloc>(context)
              //     .add(GetUserDataUserProfileEvent());

              return _buildBody(state.userLogin, context);
            }

            if (state is FailedTogetUserProfileData) {
              return Center(
                child: failedWidget(context),
              );
            }

            return Container();
          },
        ));
  }
}

Widget failedWidget(BuildContext context) {
  return FlatButton(
    child: Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: Icon(
              FontAwesomeIcons.powerOff,
              size: 60,
              color: Colors.red[100],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Tap to Login",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    ),
    onPressed: () {
      UserAuthRepository userAuthRepository = UserAuthRepository();
      // Methods.storeGuestValueToSharedPref(false);

      BlocProvider.of<UserAuthBloc>(context).add(AuthLoggedOut());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => App(
            userRepository: userAuthRepository,
          ),
        ),
      );
    },
  );
}

Widget _buildBody(UserLogin userLogin, BuildContext context) {
  return SingleChildScrollView(
    child: Stack(
      children: [
        Column(
          children: [
            // Container(height:MediaQuery.of(context).size.height * 0.20),
            topClipper(context),
          ],
        ),
        Column(
          children: <Widget>[
            ProfileHeader(
              imageUrl: userLogin.data.user.images[0].url == null ||
                      userLogin.data.user.images[0].url == ""
                  ? APIConstants.userImagePlaceHolder
                  : userLogin.data.user.images[0].url,
              backgroundImageUrl: userLogin.data.user.images[0].url == null ||
                      userLogin.data.user.images[0].url == ""
                  ? APIConstants.userImagePlaceHolder
                  : userLogin.data.user.images[0].url,
              title: userLogin.data.user.name == null ||
                      userLogin.data.user.name == ""
                  ? "N/A"
                  : userLogin.data.user.name,

              subtitle: userLogin.data.user.email == null ||
                      userLogin.data.user.email == ""
                  ? "N/A"
                  : userLogin.data.user.email,
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

class UserInfo extends StatelessWidget {
  UserInfo({@required this.userLogin});

  final UserLogin userLogin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 25),
      child: Card(
        elevation: 16,
        color: Colors.white.withOpacity(0.90),
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
                            "User Information",
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .copyWith(fontSize: 18),
                            textAlign: TextAlign.left,
                          ),
                        ),

                        Container(
                          height: 50,
                          width: 50,
                          decoration: new BoxDecoration(
                            color: AppTheme.appBackgroundColorforCard2,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0.0),
                              topRight: Radius.circular(4.0),
                              bottomLeft: Radius.circular(35.0),
                              bottomRight: Radius.circular(0.0),
                            ),
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )
                        // IconButton(
                        //     icon: Padding(
                        //       padding: const EdgeInsets.only(right: 15.0),
                        //       child: Icon(
                        //         Icons.edit,
                        //         size: 28,
                        //         color: AppTheme.appDefaultColor,
                        //       ),
                        //     ),
                        //     onPressed: () {
                        //       // Navigator.push(
                        //       //   context,
                        //       //   MaterialPageRoute(
                        //       //       builder: (context) =>
                        //       //           UserProfileUpdateScreenMain()),
                        //       // );
                        //     }),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
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
                                    color: AppTheme.appBackgroundColorforCard2,
                                  ),
                                  title: Text(
                                    "Role",
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                  subtitle: userLogin.data.user.roles == null ||
                                          userLogin.data.user.roles == ""
                                      ? Text("N/A")
                                      : Text(
                                          "Available as ${userLogin.data.user.roles == "1" ? "'Player'" : "'Agent'"}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(fontSize: 12),
                                        ),
                                ),
                                ListTile(
                                  dense: true,
                                  leading: Icon(
                                    FontAwesomeIcons.coins,
                                    color: AppTheme.nearlyGold,
                                  ),
                                  title: Text(
                                    "Coins",
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                  subtitle: userLogin.data.user.coins == null ||
                                          userLogin.data.user.coins == ""
                                      ? Text("N/A")
                                      : Text(
                                          "Total Coins : ${userLogin.data.user.coins}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(fontSize: 12),
                                        ),
                                ),
                                ListTile(
                                  dense: true,
                                  leading: Icon(
                                    Icons.email,
                                    color: Colors.redAccent,
                                  ),
                                  title: Text(
                                    "Email",
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                  subtitle: userLogin.data.user.email == null ||
                                          userLogin.data.user.email == ""
                                      ? Text("N/A")
                                      : Text(
                                          "${userLogin.data.user.email}",
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
                                      "Phone",
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                    subtitle:
                                        userLogin.data.user.contacts[0].phone ==
                                                    null ||
                                                userLogin.data.user.contacts[0]
                                                        .phone ==
                                                    ""
                                            ? Text("N/A")
                                            : Text(
                                                "${userLogin.data.user.contacts[0].phone}",
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
                                      "WhatsApp",
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                    subtitle: userLogin.data.user.contacts[0]
                                                    .whatsapp ==
                                                null ||
                                            userLogin.data.user.contacts[0]
                                                    .whatsapp ==
                                                ""
                                        ? Text("N/A")
                                        : Text(
                                            "${userLogin.data.user.contacts[0].whatsapp}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .copyWith(fontSize: 12),
                                          )),
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
    double dynamicPadding = MediaQuery.of(context).size.height * 0.14;
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

class Avatar extends StatelessWidget {
  const Avatar(
      {Key key,
      @required this.imageUrl,
      this.borderColor,
      this.backgroundColor,
      this.radius,
      this.borderWidth})
      : super(key: key);

  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final String imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CirculerImageView(
      height: 100,
      width: 100,
      imageUrl: imageUrl,
    );
  }
}
