import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:locteca/bloc/userAuthBloc/userAuthBloc.dart';
import 'package:locteca/bloc/userLoginBloc/loginBloc.dart';
import 'package:locteca/bloc/userLoginBloc/loginEvent.dart';
import 'package:locteca/bloc/userLoginBloc/loginState.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/config/networkConnectivity.dart';
import 'package:locteca/repository/userAuthRepository.dart';
import 'package:locteca/ui/CommonWidget/commonWidgets.dart';
import 'package:locteca/ui/Screen/SignUpScreen/signUpScreen.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginPage extends StatelessWidget {
  final UserAuthRepository userAuthRepository;

  LoginPage({Key key, this.userAuthRepository})
      : assert(userAuthRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) {
          return LoginBloc(
            userAuthBloc: BlocProvider.of<UserAuthBloc>(context),
            userAuthRepository: userAuthRepository,
          );
        },
        child: LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
//Animation for Slider
  AnimationController animationController;
  final _formKey = GlobalKey();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // callCartFromSharedPrefrences();

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    // tabBody = MyDiaryScreen(animationController: animationController);
    super.initState();
  }

  _onLoginButtonPressed() {
    BlocProvider.of<LoginBloc>(context).add(
      LoginButtonPressed(
        userName: _usernameController.text,
        password: _passwordController.text,
      ),
    );
  }

  void showMessageError(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: color,
      content: new Text(
        message,
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      duration: const Duration(seconds: 1),
    ));
  }

  // void callCartFromSharedPrefrences() async {
  //   BlocProvider.of<CartBloc>(context)
  //       .add(GetDataFromSharedPrefrencesCartEvent());
  // }

  @override
  void dispose() {
    // BlocProvider.of<CartBloc>(context)
    //     .add(SaveDataToSharedPrefrencesCartEvent());
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.paused) {
  //     BlocProvider.of<CartBloc>(context)
  //         .add(SaveDataToSharedPrefrencesCartEvent());
  //   }

  //   if (state == AppLifecycleState.resumed) {
  //     BlocProvider.of<CartBloc>(context)
  //         .add(GetDataFromSharedPrefrencesCartEvent());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginFailure) {
        showMessageError("${state.error}");
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Form(
        key: _formKey,
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Container(),
              // leading: new IconButton(
              //   icon: new Icon(Icons.arrow_back, color: Colors.black54),
              //   onPressed: () => Navigator.of(context).pop(),
              // ),
            ),
            key: _scaffoldKey,
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Flex(
                  direction: Axis.vertical,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Column(
                      children: [
                        //SizedBox(height: 150),
                        topClipper(context),
                        SizedBox(height: 20),
                        //Image logo
                        Center(
                          child: Container(
                              height: 150,
                              width: 250,
                              child: Image.asset('assets/images/splash.png')),
                        ),
                        SizedBox(height: 30),
                        // loginText(context),
                        Container(
                          child: state is LoginInProgress
                              ? CommonWidgets.progressIndicator
                              : loginText(context),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40.0, right: 40, top: 30),
                          child: Column(
                            children: [
                              //user name field
                              userNameInputField(context),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 1.0,
                                decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                      colors: [
                                        Colors.purpleAccent,
                                        AppTheme.drawerBackgroundColor1
                                      ],
                                      begin: Alignment(1.0, 0.0),
                                      end: Alignment(0.0, 1.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                              ),

                              SizedBox(height: 10),

                              //Password field
                              passwordInputField(context),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 1.0,
                                decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                      colors: [
                                        Colors.purpleAccent,
                                        AppTheme.drawerBackgroundColor1
                                      ],
                                      begin: Alignment(1.0, 0.0),
                                      end: Alignment(0.0, 1.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                              ),
                              SizedBox(height: 35),
                              //login button
                              loginButton(context),
                              SizedBox(height: 30),
                              forgotPasswordText(context),
                              SizedBox(height: 15),
                              registernewAccountText(context),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: bottomClipper(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      );
    }));
  }

  Widget loginText(BuildContext context) {
    return Text("Login".tr().toString(),
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(fontWeight: FontWeight.w600, color: Colors.black87));
  }

  Widget userNameInputField(BuildContext context) {
    return TextFormField(
      controller: _usernameController,
      keyboardType: TextInputType.text,
      cursorColor: AppTheme.appCardColor,

      autocorrect: false,

      //validator: _validateFirstName,
      maxLength: 128,
      style: TextStyle(
        color: Colors.black54,
        //fontFamily: ScreensFontFamlty.FONT_FAMILTY
      ),
      decoration: InputDecoration(
          counterText: "",
          // prefixIcon: Icon(
          //   Icons.person,
          //   size: 22,
          //   color: Color(0xFF72868a),
          // ),
          // contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          // border: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // enabledBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // focusedBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // errorBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          labelText: "Email".tr().toString(),
          labelStyle: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(fontWeight: FontWeight.w600, color: Colors.black38)

          // errorStyle: AppTypoGraphy.errorHintStyle
          ),

      validator: (String userName) {
        if (userName.isEmpty) {
          return "User Name";
        } else {
          return null;
        }
      },
    );
  }

  Widget passwordInputField(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      keyboardType: TextInputType.text,
      obscureText: true,
cursorColor: AppTheme.appCardColor,
      autocorrect: false,

      //validator: _validateFirstName,
      maxLength: 128,
      style: TextStyle(
        color: Colors.black54,
        //fontFamily: ScreensFontFamlty.FONT_FAMILTY
      ),
      decoration: InputDecoration(
          counterText: "",
          // prefixIcon: Icon(
          //   Icons.person,
          //   size: 22,
          //   color: Color(0xFF72868a),
          // ),
          // contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          // border: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // enabledBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // focusedBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // errorBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          labelText: "Password".tr().toString(),
          labelStyle: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(fontWeight: FontWeight.w600, color: Colors.black38)

          // errorStyle: AppTypoGraphy.errorHintStyle
          ),

      validator: (String password) {
        if (password.isEmpty) {
          return "Password";
        } else {
          return null;
        }
      },
    );
  }

  Widget loginButton(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: Container(
          // margin: EdgeInsets.only(top: 0.0),
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            gradient: new LinearGradient(
                colors: [
                  AppTheme.appDefaultColor,
                  AppTheme.appDefaultColor,
                ],
                begin: const FractionalOffset(0.0, 1.0),
                end: const FractionalOffset(0.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: MaterialButton(
              highlightColor: AppTheme.appBackgroundColorforCard4,
              splashColor: AppTheme.appBackgroundColorforCard1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 82.0),
                child: Text("Sign In".tr().toString(),
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white)),
              ),
              onPressed: () async {
                print("Login Button clicked");

                NetworkConnectivity.check().then((internet) {
                  if (internet) {
                    _onLoginButtonPressed();
                  } else {
                    //show network erro
                    showMessageError("Check Network Conection".tr().toString(),);
                  }
                });

                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => DashboardScreen()));
              }

              // showInSnackBar("Login button pressed")

              ),
        ),
      ),
    );
  }

  Widget forgotPasswordText(BuildContext context) {
//return Text("FORGOT PASSWORD?", style:  GoogleFonts.lato());
    return InkWell(
      child: Text("Forget Your Password ?".tr().toString(),
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: AppTheme.appDefaultColor,
                decoration: TextDecoration.underline,
                decorationThickness: 2,
                decorationStyle: TextDecorationStyle.solid,
                decorationColor: AppTheme.appDefaultColor,
              )),
      onTap: () {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => ForgetPasswordScreenMain()));
      },
    );
  }

  Widget registernewAccountText(BuildContext context) {
//return Text("FORGOT PASSWORD?", style:  GoogleFonts.lato());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Dont Have Anaccount ?".tr().toString(),
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.black38, fontSize: 12)),
        SizedBox(
          width: 10,
        ),
        InkWell(
          highlightColor: Colors.blue[100],
          child: Text("Register Now".tr().toString(),
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: AppTheme.appDefaultColor,
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    decorationThickness: 2,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: AppTheme.appDefaultColor,
                  )),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
        ),
      ],
    );
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

  Widget topClipper(BuildContext context) {
//return Text("FORGOT PASSWORD?", style:  GoogleFonts.lato());
    return Stack(children: [
      ClipPath(
        clipper: OvalBottomBorderClipper(),
        child: Container(
          height: 100,
          color: Colors.blue[100].withOpacity(0.7),
          child: Center(child: Text("")),
        ),
      ),
      ClipPath(
        clipper: WaveClipperTwo(reverse: false),
        child: Container(
          height: 170,
          color: Colors.blue[900].withOpacity(0.1),
          child: Center(child: Text("")),
        ),
      ),
      ClipPath(
        clipper: WaveClipperOne(reverse: false),
        child: Container(
          height: 150,
          color: Colors.blue[600].withOpacity(0.1),
          child: Center(child: Text("")),
        ),
      ),
    ]);
  }
}
