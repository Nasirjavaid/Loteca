import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:easy_localization/easy_localization.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white38),
           title: Text(
          "Contact Us".tr().toString(),
          style: Theme.of(context).textTheme.button.copyWith(
              color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w700),
        ),),
        bottomNavigationBar: ContactUsBottomAppBar(
          companyName: 'Brixton Inc.',
          textColor: Colors.white,
          backgroundColor: AppTheme.appDefaultColor,
          email: 'nasirjavaid73@gmail.com',
        ),
        backgroundColor: AppTheme.appDefaultColor,
        body: ContactUs(
          cardColor: Colors.white,
          textColor: Colors.teal.shade900,
          logo: AssetImage('assets/images/splash.png'),
          email: 'nasirjavaid73@gmail.com',
          companyName: 'Loteca 2.0',
          companyColor: Colors.teal.shade100,
          phoneNumber: '+923215198085',
          website: 'https://www.google.com/',
       
          linkedinURL: 'https://www.google.com/',
          tagLine: 'Brixton Inc.',
          taglineColor: Colors.teal.shade100,
          twitterHandle: 'https://www.google.com/',
          instagram: 'https://www.google.com/',
        ),
      
    );
  }
}