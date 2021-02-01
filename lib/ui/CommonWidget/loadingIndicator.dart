import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:locteca/config/appTheme.dart';

class LoadingIndicator extends StatelessWidget {

  final Color color;
  LoadingIndicator(this.color);
  @override
  Widget build(BuildContext context) => Center(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
              child: SpinKitFadingCircle(
            color: AppTheme.appCardColor,
            size: 50.0,
          ))

          //      CircularProgressIndicator(
          //   backgroundColor: Colors.purple,
          // ))),
          ));
}
