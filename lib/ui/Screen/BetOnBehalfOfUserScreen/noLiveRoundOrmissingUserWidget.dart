library custom_dialog;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/sendCoinBloc/sendCoinBloc.dart';
import 'package:locteca/bloc/sendCoinBloc/sendCoinEvent.dart';
import 'package:locteca/config/appTheme.dart';

class NoLiveRoundOrmissingUserWidget extends StatelessWidget {
  final Text content;
  final Text title;
  final Color firstColor;
  final Color secondColor;
  final Icon headerIcon;

  NoLiveRoundOrmissingUserWidget({
    this.content,
    this.title,
    this.firstColor,
    this.secondColor,
    this.headerIcon,
  });
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 8,
      backgroundColor: Colors.transparent,
      child: buildChild(context),
    );
  }

  buildChild(BuildContext context) => Container(
        height: 350,
        decoration: BoxDecoration(
          color: firstColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 6.0, 6.0, 0),
              child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.transparent,
                      size: 25.0,
                    ),
                    onPressed: () {},
                  )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: headerIcon,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: secondColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    title,
                    content,
                   Spacer(),
                    submitButton(context),
                    SizedBox(height: 12,)
                  ],
                ),
              ),
            )
          ],
        ),
      );



      Widget submitButton(BuildContext context) {
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
                colors: [AppTheme.nearlyGold, Colors.amber],
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

                child: Text("Back",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white)),
              ),
              onPressed: () async {
                // print("check availability button pressed");

               
                BlocProvider.of<SendCoinBloc>(context)
                        .add(ShowUserValidationFormForBetEvent());
              }),
        ),
      ),
    );
  }

}

class DialogHelper {
  static exit(context) =>
      showDialog(context: context, builder: (context) => NoLiveRoundOrmissingUserWidget());
}
