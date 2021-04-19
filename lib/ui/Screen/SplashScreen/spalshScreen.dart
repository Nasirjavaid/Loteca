// import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:retaurant_app/ui/Screen/LoginScreen/loginScreen.dart';


class SplashScreen extends StatelessWidget{
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                height: 400,
                width: 300,
                child: Image.asset('assets/images/splash.png')),
                //SizedBox(height: 15,),
               // Text("Loteca 2.0",style:Theme.of(context).textTheme.headline4.copyWith(fontWeight:FontWeight.w900,color:Colors.black87))
          ],
        ),
      ),
    );
  }
}