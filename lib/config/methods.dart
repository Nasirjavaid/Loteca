import 'dart:convert';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/model/mainRound.dart';
import 'package:locteca/model/sendCoin.dart';
import 'package:locteca/model/userLogin.dart';
import 'package:locteca/model/validateUser.dart';
import 'package:locteca/ui/Screen/Buy/agentDetailDialogue.dart';
import 'package:locteca/ui/Screen/MakeBet/emailNotVerifiedDialogue.dart';
import 'package:locteca/ui/Screen/MakeBet/userBetRecipt.dart';
import 'package:locteca/ui/Screen/SendCoinScreen/coinsRecipt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class Methods {
  static void showInfoFlushbarHelper(
      BuildContext context, String title, String message) {
    FlushbarHelper.createSuccess(
      title: title,
      message: message,
    ).show(context);
  }
  //Url Launcher
  // static launchURL() async {
  //   const url = 'https://www.visionplus.com.pk/';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  //Storing user information in shared prefrences

  //getCurrent date and time of system

  static String getSytemCurrenDateAndTime() {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    print(
        "Current date and time sent to server while placing order::   $date ");
    return date.toString();
  }

  static void showToast(BuildContext context, String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 2000),
        backgroundColor: AppTheme.appDefaultColor,
        content:
            Text("$message", style: TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }

//   static storeGuestValueToSharedPref(bool guestBoolValue) async {
//     SharedPreferences sharedUser = await SharedPreferences.getInstance();

//     // String user = jsonEncode(userLogin.toJson());
//     String guestValue = "guest";

//     print("Guest Stored in  shared pref :: $guestBoolValue");
//     sharedUser.setBool(guestValue, guestBoolValue);
//   }

// //getting user information from shared pefrences
//   static Future<bool> getGuestFromSharedPref() async {
//     SharedPreferences sharedUser = await SharedPreferences.getInstance();

//     try {
//       String guestValue = "guest";
//       bool guestBoolValue = sharedUser.getBool(guestValue);
//       if (guestBoolValue) {
//         print("Guest  value back from shared pref :: $guestBoolValue");
//         return guestBoolValue;
//       }
//     } catch (ex) {
//       print("Exception in Shared prefrences $ex");
//       return false;
//     }
//     return false;
//   }

  //Storing user information in shared prefrences
  static storeUserToSharedPref(UserLogin userLogin) async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();

    String user = jsonEncode(userLogin.toJson());

    print("User object Stored in  shared pref :: $user");
    sharedUser.setString('user', user);
  }

  static Future<UserLogin> userInfoStoredInsharedPrefrences() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    UserLogin userLogin = UserLogin();
    Map userMap;

    try {
      userMap = jsonDecode(sharedUser.getString('user'));

      if (userMap.length.isNegative) {
        return userLogin;
      } else {
        userLogin = UserLogin.fromJson(userMap);
        print(
            "Returned User info by shared prefrences   ${userLogin.data.token} ");
        return userLogin;
      }
    } catch (ex) {
      return userLogin;
    }
  }

//getting user information from shared pefrences
  static Future<UserLogin> getRealUserFromSharedPref() async {
    // SharedPreferences sharedUser = await SharedPreferences.getInstance();
    UserLogin userLogin = UserLogin();
    userLogin = await userInfoStoredInsharedPrefrences();
    try {
      //  Map userMap = jsonDecode(sharedUser.getString('user'));

      if (userLogin.data.token != "") {
        return userLogin;
      }
    } catch (ex) {
      print("Exception in Shared prefrences $ex");
      return userLogin;
    }
    return userLogin;
  }

  static String dateToDateTimeConversion(String mydate) {
    DateTime dd = DateTime.parse(mydate);

    dd.toString();
    print("Date time in mili seconds :: ${dd.year}");
    print("Date time in mili seconds :: ${dd.month}");
    print("Date time in mili seconds :: ${dd.day}");
    print("Date time in mili seconds :: ${dd.hour}");
    print("Date time in mili seconds :: ${dd.minute}");
    String formattedDate = DateFormat('EEE,dd-MM-yyyy, hh:mm:aa').format(dd);
    return formattedDate;
  }

  // static void showDialogMenuListAddons(
  //     BuildContext context, Foodinfo foodinfo) {
  //   showGeneralDialog(
  //     barrierLabel: "Customizations",
  //     barrierDismissible: true,
  //     barrierColor: Colors.black.withOpacity(0.5),
  //     transitionDuration: Duration(milliseconds: 400),
  //     context: context,
  //     pageBuilder: (_, __, ___) {
  //       return AddonsDialogue(
  //         foodinfo: foodinfo,
  //         contextA: context,
  //       );
  //     },
  //     transitionBuilder: (_, anim, __, child) {
  //       return SlideTransition(
  //         position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
  //         child: child,
  //       );
  //     },
  //   );
  // }

  static void showDialogWithAgentDetail(BuildContext context, agents) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 400),
      barrierDismissible: true,
      barrierLabel: '',

      context: context,

      pageBuilder: (_, __, ___) {
        return AgentDetailDialogue(agents: agents);
      },

      // transitionBuilder: (context, animation, anotherAnimation, child) {
      //   return FadeTransition(
      //     opacity: animation,
      //     child: child,
      //   );
      // },

      transitionBuilder: (context, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  static void showDialogueForUserBetDetail(
      BuildContext context, MainRound mainRound, ValidateUser validateUser) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.25),
      transitionDuration: Duration(milliseconds: 400),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (_, __, ___) {
        return UserBetRecipt(mainRound: mainRound, validateUser: validateUser);
      },

      // transitionBuilder: (context, animation, anotherAnimation, child) {
      //   return FadeTransition(
      //     opacity: animation,
      //     child: child,
      //   );
      // },

      transitionBuilder: (context, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
    // }
  }

  static void showDialogueForCoinSentDetail(
      BuildContext context, SendCoin sendCoin) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.25),
      transitionDuration: Duration(milliseconds: 400),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (_, __, ___) {
        return CoinRecipt(sendCoin: sendCoin);
      },

      // transitionBuilder: (context, animation, anotherAnimation, child) {
      //   return FadeTransition(
      //     opacity: animation,
      //     child: child,
      //   );
      // },

      transitionBuilder: (context, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
    // }
  }

  static void showDialogForEmailVerification(BuildContext context) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 400),
      barrierDismissible: true,
      barrierLabel: '',

      context: context,

      pageBuilder: (_, __, ___) {
        return EmailNotVerifiedDialogue(
          contextB: context,
          content: Text(
            "Your have to verify your email address for joining the round. Email with code is already sent to your email address.".tr().toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption.copyWith(color: Colors.black45),
          ),
          title: Text(
            "Email Verification".tr().toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
          firstColor: Colors.redAccent,
          secondColor: Colors.white,
          headerIcon: Icon(
            Icons.security_rounded,
            size: 120,
            color: Colors.white70
          ),
        );
      },

      // transitionBuilder: (context, animation, anotherAnimation, child) {
      //   return FadeTransition(
      //     opacity: animation,
      //     child: child,
      //   );
      // },

      transitionBuilder: (context, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 2), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }
}

mixin ValidationMixin {
  bool isFieldEmpty(String fieldValue) => fieldValue?.isEmpty ?? true;

  bool validateEmailAddress(String email) {
    if (email == null) {
      return false;
    }
    String emailTrimmed = email.trim();
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(emailTrimmed);
  }

  bool validatePassword(String value) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex = new RegExp(pattern);
    print(value);
    if (value.isEmpty) {
      return false;
    } else {
      if (!regex.hasMatch(value))
        return false;
      else
        return true;
    }
  }
}

//validating login fields
enum FieldError { Empty, Invalid }
