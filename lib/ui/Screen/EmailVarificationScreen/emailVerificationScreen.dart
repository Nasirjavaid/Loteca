import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locteca/bloc/sendCoinBloc/sendCoinBloc.dart';
import 'package:locteca/bloc/sendCoinBloc/sendCoinEvent.dart';

import 'package:locteca/bloc/sendCoinBloc/sendCoinState.dart';
import 'package:locteca/bloc/userAuthBloc/userAuthBloc.dart';
import 'package:locteca/bloc/userAuthBloc/userAuthEvent.dart';
import 'package:locteca/bloc/userAuthBloc/userAuthState.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/config/methods.dart';
import 'package:locteca/config/networkConnectivity.dart';

import 'package:locteca/main.dart';
import 'package:locteca/repository/userAuthRepository.dart';
import 'package:locteca/ui/CommonWidget/commonWidgets.dart';
import 'package:easy_localization/easy_localization.dart';

// class EmailVerificationScreenMain extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: BlocProvider(
//         create: (context) {
//           return UserAuthBloc()..add(ShowUserValidationFormSendCoinEvent());
//         },
//         child: EmailVerificationScreen(),
//       ),
//     );
//   }
// }

class EmailVerificationScreen extends StatefulWidget {
  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final userRepository = UserAuthRepository();
  TextEditingController etCode = TextEditingController();

  void showMessageError(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: color,
      content: new Text(
        message,
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      duration: const Duration(seconds: 2),
    ));
  }

  _submitButtonPressed() {
    if (etCode.text == null || etCode.text.isEmpty) {
      showMessageError(
        "Please enter code".tr().toString(),
      );
    } else {
      BlocProvider.of<UserAuthBloc>(context).add(
        AuthVerifyEmail(code: etCode.text),
      );
    }
  }

  _resendCode() {
    BlocProvider.of<UserAuthBloc>(context).add(
      AuthReSendCode(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
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
      child: Scaffold(
        key: _scaffoldKey,
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white38),
          title: Text(
            "Email Verification".tr().toString(),
            style: Theme.of(context).textTheme.button.copyWith(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),

          centerTitle: true,
          elevation: 0.0,
          actions: [
            IconButton(
                icon: Icon(
                  FontAwesomeIcons.questionCircle,
                  color: Colors.white38,
                  size: 18,
                ),
                onPressed: null),
          ],
          // toolbarHeight: 50,

          backgroundColor: AppTheme.appDefaultColor,
          //backgroundColor: Colors.transparent,
          // title: Text(
          //   "Loteca",
          //   style:
          //       Theme.of(context).textTheme.button.copyWith(color: Colors.white),
          // ),
        ),
        backgroundColor: AppTheme.background,
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
// return BlocConsumer<MainRoundBloc, MainRoundState>(
//       buildWhen: (previousState, state) {
//         return state is! DontBuild;
//       },
//       builder: (BuildContext context, state) {
//         return Text(state.text);
//       },
//       listener: (BuildContext context, state) {
//         if (state is ShowFlushbar) {

//         }
//       },
//     );

    return BlocListener<UserAuthBloc, UserAuthState>(
        listener: (context, state) {
      if (state is AuthCodeVerificationFailed) {
        showMessageError("${state.feedback.message}");
      }
      if (state is AuthCodeResentSuccessfully) {
        showMessageError("${state.feedback.message}");
      }

      if (state is AuthCodeVerificationMessage) {
        showMessageError("${state.feedback.message}");
      }

      if (state is AuthCodeVerifiedSuccessfully) {
        Navigator.pop(context, "I'm back **********************");
      }
    }, child:
            BlocBuilder<UserAuthBloc, UserAuthState>(builder: (context, state) {
      return _buildCardWidget(context, state);
    }));
  }

  Widget _buildCardWidget(BuildContext contex, state) {
    return Container(
      padding: EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: 25,
            // ),
            // Text("Pease Enter League Name"),
            SizedBox(
              height: 25,
            ),
            enterCodeInputField(context),
            SizedBox(
              height: 30,
            ),
            resendCode(context),
            SizedBox(
              height: 20,
            ),

            state is AuthInProgress
                ? CommonWidgets.progressIndicator
                : submitCodeButton(context),

            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  Widget enterCodeInputField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.06,
      child: new TextField(
          controller: etCode,
          cursorColor: AppTheme.appDefaultColor,
          expands: false,
          maxLines: 1,
          minLines: 1,
          keyboardType: TextInputType.text,
          autocorrect: false,

          //validator: _validateFirstName,

          decoration: InputDecoration(
            prefixIcon: Icon(Icons.security, color: Colors.grey),
            counterText: "",
            // filled: true,
            // fillColor: AppTheme.appDefaultColor,
            labelText: "Enter Code".tr().toString(),
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

  Widget resendCode(BuildContext context) {
    return Container(
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Didn't recevie the code yet ?".tr().toString(),
                style: Theme.of(context).textTheme.bodyText1),
            SizedBox(
              width: 8,
            ),
            InkWell(
              onTap: () {
                _resendCode();
              },
              child: Text("Resend Code".tr().toString(),
                  style: Theme.of(context).textTheme.button.copyWith(
                        color: AppTheme.appDefaultColor,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                        decorationStyle: TextDecorationStyle.solid,
                        decorationColor: AppTheme.appDefaultColor,
                      )),
            ),
          ]),
    );
  }

  Widget submitCodeButton(BuildContext context) {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.5,
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
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),

//checking user before placing the order
                // child: guestUserValue
                //     ? Text("Sign In",
                //         style: Theme.of(context).textTheme.bodyText2.copyWith(
                //             fontWeight: FontWeight.w600, color: Colors.white))
                //     : Text("Check out",
                //         style: Theme.of(context).textTheme.bodyText2.copyWith(
                //             fontWeight: FontWeight.w600, color: Colors.white)),

                child: Text("Verify Now".tr().toString(),
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white)),
              ),
              onPressed: () async {
                // print("check availability button pressed");

                NetworkConnectivity.check().then((internet) {
                  if (internet) {
                    _submitButtonPressed();
                  } else {
                    //show network erro

                    Methods.showToast(
                        context, "Check your network".tr().toString());
                  }
                });
              }),
        ),
      ),
    );
  }

  Widget myMainCard(
    String title,
    IconData iconData,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.background,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
              topLeft: Radius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    iconData,
                    color: Colors.black45,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 1,
                    height: MediaQuery.of(context).size.height * 0.03,
                    color: Colors.black26,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "$title ",
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(fontSize: 12),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_downward,
                color: Colors.black45,
                size: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
