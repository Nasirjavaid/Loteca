import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:locteca/config/appTheme.dart';

class CommonWidgets {
  static final progressIndicator =  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              height: 17,
              width: 17,
              margin: EdgeInsets.all(5),
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                backgroundColor: Colors.blue,
              ),
            ),
          ),
        ],
      );


      static final progressIndicatorCustom = Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: SpinKitFadingCircle(
            color: AppTheme.appCardColor,
            size: 50.0,
              )
          ),
        ],
      ));
}

