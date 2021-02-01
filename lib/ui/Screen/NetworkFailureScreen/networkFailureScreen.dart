import 'package:flutter/material.dart';
import 'package:locteca/repository/userAuthRepository.dart';

import '../../../main.dart';

class NetworkFauilureScreen extends StatelessWidget {
 final BuildContext contextA;

  final UserAuthRepository userAuthRepository = UserAuthRepository();

  NetworkFauilureScreen({this.contextA});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: failureWidget(context),
    );
  }

  Widget failureWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => App(
              userRepository: userAuthRepository,
            ),
          ),
        );
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off,
              size: 60,
              color: Colors.black38,
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Tap to reload",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Network NOT available",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
