// import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:retaurant_app/ui/Screen/LoginScreen/loginScreen.dart';


class SplashScreen extends StatelessWidget{
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
            height: 100,
            width: 100,
            child: Image.asset('assets/images/splash.png')),
      ),
    );
  }
}