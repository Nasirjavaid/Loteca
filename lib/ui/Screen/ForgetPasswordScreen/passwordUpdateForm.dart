import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/passwordRecoveryBloc/passwordRecoveryBloc.dart';
import 'package:locteca/bloc/passwordRecoveryBloc/passwordRecoveryEvent.dart';

import 'package:locteca/config/appTheme.dart';
import 'package:locteca/config/methods.dart';
import 'package:locteca/config/networkConnectivity.dart';
import 'package:easy_localization/easy_localization.dart';

class PasswordUpdateForm extends StatefulWidget {
  final String email;
  PasswordUpdateForm({this.email});
  @override
  _PasswordUpdateFormState createState() => _PasswordUpdateFormState();
}

class _PasswordUpdateFormState extends State<PasswordUpdateForm> {
  String selectedDate;
  String selectedTime;

  TextEditingController etEmail = TextEditingController();
  TextEditingController etPassword = TextEditingController();
  TextEditingController etConfirmPassword = TextEditingController();

  void _showToast(BuildContext context, String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 2000),
        backgroundColor: Colors.red,
        content:
            Text("$message", style: TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }

  _submitButtonPressed() {
    if (etEmail.text == null || etEmail.text.isEmpty) {
      _showToast(
        context,
        "Please enter email".tr().toString(),
      );
    } else if (etPassword.text == null || etPassword.text.isEmpty) {
      _showToast(
        context,
        "Please Enter Password".tr().toString(),
      );
    } else if (etPassword.text.length <= 3) {
      _showToast(
        context,
        "Password length must be more or equal to 4 characters".tr().toString(),
      );
    } else if (etPassword.text.trim() != etConfirmPassword.text.trim()) {
      _showToast(
        context,
        "Password doesn't match".tr().toString(),
      );
    } else {
      BlocProvider.of<PasswordRecoveryBloc>(context).add(
        UpdatePassowrdEvent(email: etEmail.text, password: etPassword.text),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    etEmail.text = email;

    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: 25,
            // ),
            // Text("Pease Enter League Name"),
            SizedBox(
              height: 25,
            ),
            enterEmailInputFiled(context),
            SizedBox(
              height: 20,
            ),
            passwordInputFiled(context),
            SizedBox(
              height: 10,
            ),
            confirmPassordInputFiled(context),
            SizedBox(
              height: 40,
            ),
            submitButton(context),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  Widget enterEmailInputFiled(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.06,
      child: new TextField(
          controller: etEmail,
          cursorColor: AppTheme.appDefaultColor,
          expands: false,
          maxLines: 1,
          minLines: 1,
          keyboardType: TextInputType.text,
          autocorrect: false,

          //validator: _validateFirstName,

          decoration: InputDecoration(
            prefixIcon: Icon(Icons.email, color: Colors.grey),
            counterText: "",
            // filled: true,
            // fillColor: AppTheme.appDefaultColor,
            labelText: "Enter email".tr().toString(),
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

  Widget passwordInputFiled(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.06,
      child: new TextField(
          controller: etPassword,
          cursorColor: AppTheme.appDefaultColor,
          expands: false,
          maxLines: 1,
          minLines: 1,
          keyboardType: TextInputType.text,
          autocorrect: false,

          //validator: _validateFirstName,

          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
            counterText: "",
            // filled: true,
            // fillColor: AppTheme.appDefaultColor,
            labelText: "Enter Password".tr().toString(),
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

  Widget confirmPassordInputFiled(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.06,
      child: new TextField(
          controller: etConfirmPassword,
          cursorColor: AppTheme.appDefaultColor,
          expands: false,
          maxLines: 1,
          minLines: 1,
          keyboardType: TextInputType.text,
          autocorrect: false,

          //validator: _validateFirstName,

          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock, color: Colors.grey),
            counterText: "",
            // filled: true,
            // fillColor: AppTheme.appDefaultColor,
            labelText: "Confirm Passowrd".tr().toString(),
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

  Widget submitButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width * 0.35,
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 12.0),
                    child: Text("Back".tr().toString(),
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                  onPressed: () async {
                    // print("check availability button pressed");
                    BlocProvider.of<PasswordRecoveryBloc>(context)
                        .add(CodeMatchingEvent(code: ""));
                  }),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width * 0.35,
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 12.0),
                    child: Text("Reset Password".tr().toString(),
                    textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
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
        ),
      ],
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
