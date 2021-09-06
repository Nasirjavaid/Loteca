import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locteca/bloc/profileUpdateBloc/userProfileUpdateBloc.dart';
import 'package:locteca/bloc/profileUpdateBloc/userProfileUpdateEvent.dart';
import 'package:locteca/bloc/profileUpdateBloc/userProfileUpdateState.dart';

import 'package:locteca/config/appTheme.dart';
import 'package:locteca/config/methods.dart';
import 'package:locteca/config/networkConnectivity.dart';
import 'package:locteca/model/userLogin.dart';
import 'package:locteca/ui/CommonWidget/commonWidgets.dart';
import 'package:locteca/ui/CommonWidget/loadingIndicator.dart';
import 'package:locteca/ui/Screen/GeneralRanking/generalRanking.dart';

class UserProfileUpdateScreenMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocProvider(
            create: (context) => UserProfileUpdateBloc()
              ..add(UserProfileUpdateGetUserDataFromSharedPrefrences()),
            child: UserProfileUpdateScreen()));
  }
}

class UserProfileUpdateScreen extends StatefulWidget {
  @override
  _UserProfileUpdateScreenState createState() =>
      _UserProfileUpdateScreenState();
}

class _UserProfileUpdateScreenState extends State<UserProfileUpdateScreen>  with WidgetsBindingObserver{
  TextEditingController etwhatsAppNumber = TextEditingController();
  TextEditingController etEmail = TextEditingController();
  TextEditingController etMobile = TextEditingController();
  TextEditingController etPasswordOld = TextEditingController();
  TextEditingController etPasswordNew = TextEditingController();
  TextEditingController etUserName = TextEditingController();
  bool imageSwitch = false;
  UserLogin userLoginGlobal = UserLogin();

  File _image;

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
if(image !=null){
    setState(() {
      _image = image;
      imageSwitch = true;
    });}
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

if(image !=null)
{
 setState(() {
      _image = image;
      imageSwitch = true;
    });
}
   
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text(
                        'Photo Library',
                        style: Theme.of(context).textTheme.button,
                      ),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text(
                      'Camera',
                      style: Theme.of(context).textTheme.button,
                    ),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showToast(BuildContext context, String message) {
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

  onUpdateButtonPressed() {
    if (_image != null) {
      BlocProvider.of<UserProfileUpdateBloc>(context).add(
          UserProfileUpdateButtonPressed(
              userLoginGlobal.data.user.roles,
              etUserName.text,
              etEmail.text,
              etPasswordOld.text,
              etPasswordNew.text,
              etMobile.text,
              etwhatsAppNumber.text,
              _image));
    } else {
      _image = new File("");
      BlocProvider.of<UserProfileUpdateBloc>(context).add(
          UserProfileUpdateButtonPressed(
              userLoginGlobal.data.user.roles,
              etUserName.text,
              etEmail.text,
              etPasswordOld.text,
              etPasswordNew.text,
              etMobile.text,
              etwhatsAppNumber.text,
              _image));
    }
  }

  Widget _buildBody(BuildContext context) {
    return BlocListener<UserProfileUpdateBloc, UserProfileUpdateState>(
        listener: (context, state) {
      if (state is UserProfileUpdateInDataFromSharedPrefrencesState) {
        userLoginGlobal = state.userLogin;
        etUserName.text = state.userLogin.data.user.name;
        etEmail.text = state.userLogin.data.user.email;
        // etPassword.text = state.userLogin.data.password;
        etMobile.text = state.userLogin.data.user.contacts[0].phone;
        etwhatsAppNumber.text = state.userLogin.data.user.contacts[0].whatsapp;
      }
      if (state is UserProfileUpdateFailure) {
        _showToast(context, "${state.error}");
      }

      if (state is UserProfileUpdateInProgress) {
        return Center(
          child: CommonWidgets.progressIndicator,
        );
      }
      if (state is UserProfileUpdateInSuccess) {
        _showToast(context, "${state.message}");
        etUserName.text = "";
        etEmail.text = "";
        etPasswordOld.text = "";
        etPasswordNew.text = "";
        etMobile.text = "";
        etwhatsAppNumber.text = "";
      }
      if (state is UserProfileUpdateSuccessAndGoToOtherScreen) {
        Navigator.pop(context, true);
      }
    }, child: BlocBuilder<UserProfileUpdateBloc, UserProfileUpdateState>(
            builder: (context, state) {
      if (state is UserProfileUPdateLoadingINdicatorScreenState) {
        return LoadingIndicator(Colors.indigo);
      }

      if (state is UserProfileUpdateInDataFromSharedPrefrencesState) {
        userLoginGlobal = state.userLogin;
        etUserName.text = state.userLogin.data.user.name;
        etEmail.text = state.userLogin.data.user.email;
        // etPassword.text = state.userLogin.data.password;
        etMobile.text = state.userLogin.data.user.contacts[0].phone;
        etwhatsAppNumber.text = state.userLogin.data.user.contacts[0].whatsapp;

        return mainForm(context, state);
      }
      if (state is UserProfileUpdateInProgress) {
        return mainForm(context, state);
      }
      return Container();
    }));
  }

  Widget mainForm(BuildContext context, state) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          topClipper(context),
          Form(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 18),
                    child: Column(
                      children: [
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // dynamicText(context, "Update Profille"),
                        SizedBox(
                          height: 50,
                        ),

                        Center(
                          child: GestureDetector(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment(0, 1),
                                  child: CircleAvatar(
                                    radius: 55,
                                    backgroundColor: AppTheme.appBackgroundColor
                                        .withOpacity(0.60),
                                    child: imageSwitch == false
                                        ? Avatar(
                                            circleShow: false,
                                            imageUrl: userLoginGlobal
                                                .data.user.images[0].url,
                                            radius: 54.5,
                                            backgroundColor: Colors.white,
                                            borderColor: Colors.grey.shade300,
                                            borderWidth: 4.0,
                                          )
                                        : _image != null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.file(
                                                  _image,
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              )
                                            : Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                width: 100,
                                                height: 100,
                                                child: Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.grey[800],
                                                ),
                                              ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Align(
                                      alignment: Alignment(0.0, 1.2),
                                      child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFFe0f2f1)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(FontAwesomeIcons.camera,
                                                size: 12,
                                                color: Colors.black26),
                                          ))),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),

                        ClipPath(
                          clipper: OvalBottomBorderClipper(),
                          child: Container(
                            // height: MediaQuery.of(context).size.height * 0.13,
                            color:
                                AppTheme.appBackgroundColor.withOpacity(0.60),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 10),
                              child: Column(children: [
                                firstNameInputField(context),
                                SizedBox(
                                  height: 10,
                                ),
                                emailInputField(context),
                                SizedBox(
                                  height: 10,
                                ),

                                // passwordInputFieldNew(context),
                                // SizedBox(
                                //   height: 35,
                                // ),
                                // dynamicText(context, "Contact Information"),
                                // SizedBox(
                                //   height: 10,
                                // ),

                                // SizedBox(
                                //   height: 10,
                                // ),
                                // lastNameInputField(context),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                phoneNumberInputField(context),
                                SizedBox(
                                  height: 10,
                                ),
                                addressInputField(context),
                                // SizedBox(
                                //   height: 10,
                                // ),

                                // passwordInputFiledOld(context),
                                // SizedBox(
                                //   height: 5,
                                // ),

                                // dynamicTextNote(context,
                                //     "If you leave password field empty, your password will remian same as previous."),
                                // SizedBox(
                                //   height: 10,
                                // ),

                                //passwordInputFieldNew(context),
                                SizedBox(
                                  height: 60,
                                ),
                                // zipCodeInputField(context),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // cityInputField(context),
                                // SizedBox(
                                //   height: 40,
                                // ),
                                state is UserProfileUpdateInProgress
                                    ? CommonWidgets.progressIndicator
                                    : registerButton(context),
                                SizedBox(
                                  height: 20,
                                ),
                                //  loginText(context),
                                SizedBox(
                                  height: 10,
                                ),
                              ]),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget topClipper(BuildContext context) {
//return Text("FORGOT PASSWORD?", style:  GoogleFonts.lato());
    return Stack(children: [
      ClipPath(
        clipper: OvalBottomBorderClipper(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.15,
          color: AppTheme.appDefaultColor,
          child: Center(child: Text("")),
        ),
      ),
      ClipPath(
        clipper: WaveClipperTwo(reverse: false),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.37,
          color: Colors.orange[900].withOpacity(0.1),
          child: Center(child: Text("")),
        ),
      ),
      ClipPath(
        clipper: WaveClipperOne(reverse: false),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.90,
          color: Colors.orange[600].withOpacity(0.1),
          child: Center(child: Text("")),
        ),
      ),
    ]);
  }

  Widget dynamicTextNote(BuildContext context, String dynamicText) {
//return Text("FORGOT PASSWORD?", style:  GoogleFonts.lato());
    return Text("$dynamicText",
        style: Theme.of(context).textTheme.button.copyWith(
              color: AppTheme.appDefaultColor,
              fontSize: 12,
            ));
  }

  Widget dynamicText(BuildContext context, String dynamicText) {
//return Text("FORGOT PASSWORD?", style:  GoogleFonts.lato());
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Text("$dynamicText",
          style: Theme.of(context).textTheme.button.copyWith(
              color: AppTheme.appDefaultColor,
              fontSize: 16,
              fontWeight: FontWeight.w800)),
    );
  }

  Widget emailInputField(BuildContext context) {
    return TextFormField(
      controller: etEmail,
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
 cursorColor: AppTheme.appCardColor,
      //controller: firstNameTextController,
      //validator: _validateFirstName,
      maxLength: 128,
      style: TextStyle(
        color: Colors.black54,
        //fontFamily: ScreensFontFamlty.FONT_FAMILTY
      ),
      decoration: InputDecoration(
          counterText: "",
          // prefixIcon: Icon(
          //   Icons.person,
          //   size: 22,
          //   color: Color(0xFF72868a),
          // ),
          // contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          // border: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // enabledBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // focusedBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // errorBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          labelText: "Email",
          labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w600, color: Colors.black38, fontSize: 14)

          // errorStyle: AppTypoGraphy.errorHintStyle
          ),

      validator: (String userName) {
        if (userName.isEmpty) {
          return "Email";
        } else {
          return null;
        }
      },
    );
  }

  Widget passwordInputFiledOld(BuildContext context) {
    return TextFormField(
      controller: etPasswordOld,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,

      //controller: firstNameTextController,
      //validator: _validateFirstName,
      maxLength: 128,
      style: TextStyle(
        color: Colors.black54,
        //fontFamily: ScreensFontFamlty.FONT_FAMILTY
      ),
      decoration: InputDecoration(
          counterText: "",
          // prefixIcon: Icon(
          //   Icons.person,
          //   size: 22,
          //   color: Color(0xFF72868a),
          // ),
          // contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          // border: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // enabledBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // focusedBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // errorBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          labelText: "Old password",
          labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w600, color: Colors.black38, fontSize: 14)

          // errorStyle: AppTypoGraphy.errorHintStyle
          ),

      validator: (String password) {
        if (password.isEmpty) {
          return "Old password";
        } else {
          return null;
        }
      },
    );
  }

  Widget passwordInputFieldNew(BuildContext context) {
    return TextFormField(
      controller: etPasswordNew,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,

      //controller: firstNameTextController,
      //validator: _validateFirstName,
      maxLength: 128,
      style: TextStyle(
        color: Colors.black54,
        //fontFamily: ScreensFontFamlty.FONT_FAMILTY
      ),
      decoration: InputDecoration(
          counterText: "",
          // prefixIcon: Icon(
          //   Icons.person,
          //   size: 22,
          //   color: Color(0xFF72868a),
          // ),
          // contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          // border: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // enabledBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // focusedBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // errorBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          labelText: "New password",
          labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w600, color: Colors.black38, fontSize: 14)

          // errorStyle: AppTypoGraphy.errorHintStyle
          ),

      validator: (String password) {
        if (password.isEmpty) {
          return "New password";
        } else {
          return null;
        }
      },
    );
  }

  Widget firstNameInputField(BuildContext context) {
    return TextFormField(
      controller: etUserName,
      cursorColor: AppTheme.appCardColor,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,

      //controller: firstNameTextController,
      //validator: _validateFirstName,
      maxLength: 128,
      style: TextStyle(
        color: Colors.black54,
        //fontFamily: ScreensFontFamlty.FONT_FAMILTY
      ),
      decoration: InputDecoration(
          counterText: "",
          // prefixIcon: Icon(
          //   Icons.person,
          //   size: 22,
          //   color: Color(0xFF72868a),
          // ),
          // contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          // border: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // enabledBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // focusedBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // errorBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          labelText: "Name",
          labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w600, color: Colors.black38, fontSize: 14)

          // errorStyle: AppTypoGraphy.errorHintStyle
          ),

      validator: (String firstName) {
        if (firstName.isEmpty) {
          return "Name";
        } else {
          return null;
        }
      },
    );
  }

  Widget lastNameInputField(BuildContext context) {
    return TextFormField(
      // controller: _usernameController,
       cursorColor: AppTheme.appCardColor,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,

      //controller: firstNameTextController,
      //validator: _validateFirstName,
      maxLength: 128,
      style: TextStyle(
        color: Colors.black54,
        //fontFamily: ScreensFontFamlty.FONT_FAMILTY
      ),
      decoration: InputDecoration(
          counterText: "",
          // prefixIcon: Icon(
          //   Icons.person,
          //   size: 22,
          //   color: Color(0xFF72868a),
          // ),
          // contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          // border: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // enabledBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // focusedBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // errorBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          labelText: "Last Name",
          labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w600, color: Colors.black38, fontSize: 14)

          // errorStyle: AppTypoGraphy.errorHintStyle
          ),

      validator: (String lasttName) {
        if (lasttName.isEmpty) {
          return "Last Name";
        } else {
          return null;
        }
      },
    );
  }

  Widget addressInputField(BuildContext context) {
    return TextFormField(
      controller: etwhatsAppNumber,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
       cursorColor: AppTheme.appCardColor,

      //controller: firstNameTextController,
      //validator: _validateFirstName,
      maxLength: 128,
      style: TextStyle(
        color: Colors.black54,
        //fontFamily: ScreensFontFamlty.FONT_FAMILTY
      ),
      decoration: InputDecoration(
          counterText: "",
          // prefixIcon: Icon(
          //   Icons.person,
          //   size: 22,
          //   color: Color(0xFF72868a),
          // ),
          // contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          // border: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // enabledBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // focusedBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // errorBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          labelText: "WhatsApp",
          labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w600, color: Colors.black38, fontSize: 14)

          // errorStyle: AppTypoGraphy.errorHintStyle
          ),

      validator: (String address) {
        if (address.isEmpty) {
          return "WhatsApp";
        } else {
          return null;
        }
      },
    );
  }

  Widget zipCodeInputField(BuildContext context) {
    return TextFormField(
      // controller: _usernameController,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
 cursorColor: AppTheme.appCardColor,
      //controller: firstNameTextController,
      //validator: _validateFirstName,
      maxLength: 128,
      style: TextStyle(
        color: Colors.black54,
        //fontFamily: ScreensFontFamlty.FONT_FAMILTY
      ),
      decoration: InputDecoration(
          counterText: "",
          // prefixIcon: Icon(
          //   Icons.person,
          //   size: 22,
          //   color: Color(0xFF72868a),
          // ),
          // contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          // border: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // enabledBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // focusedBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // errorBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          labelText: "Zip Code",
          labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w600, color: Colors.black38, fontSize: 14)

          // errorStyle: AppTypoGraphy.errorHintStyle
          ),

      validator: (String zipCode) {
        if (zipCode.isEmpty) {
          return "Zip Code";
        } else {
          return null;
        }
      },
    );
  }

  Widget phoneNumberInputField(BuildContext context) {
    return TextFormField(
      controller: etMobile,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
 cursorColor: AppTheme.appCardColor,
      //controller: firstNameTextController,
      //validator: _validateFirstName,
      maxLength: 128,
      style: TextStyle(
        color: Colors.black54,
        //fontFamily: ScreensFontFamlty.FONT_FAMILTY
      ),
      decoration: InputDecoration(
          counterText: "",
          // prefixIcon: Icon(
          //   Icons.person,
          //   size: 22,
          //   color: Color(0xFF72868a),
          // ),
          // contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          // border: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // enabledBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // focusedBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // errorBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          labelText: "Phone number",
          labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w600, color: Colors.black38, fontSize: 14)

          // errorStyle: AppTypoGraphy.errorHintStyle
          ),

      validator: (String phoneNumber) {
        if (phoneNumber.isEmpty) {
          return "Phone number";
        } else {
          return null;
        }
      },
    );
  }

  Widget cityInputField(BuildContext context) {
    return TextFormField(
      // controller: _usernameController,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
 cursorColor: AppTheme.appCardColor,
      //controller: firstNameTextController,
      //validator: _validateFirstName,
      maxLength: 128,
      style: TextStyle(
        color: Colors.black54,
        //fontFamily: ScreensFontFamlty.FONT_FAMILTY
      ),
      decoration: InputDecoration(
          counterText: "",
          // prefixIcon: Icon(
          //   Icons.person,
          //   size: 22,
          //   color: Color(0xFF72868a),
          // ),
          // contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          // border: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // enabledBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // focusedBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          // errorBorder: const OutlineInputBorder(
          //     borderSide: const BorderSide(
          //         // color: Color.fromARGB(255, 232, 232, 232),
          //         color: Colors.white,
          //         width: 1.0),
          //     borderRadius: BorderRadius.all(Radius.circular(25))),
          labelText: "City",
          labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w600, color: Colors.black38, fontSize: 14)

          // errorStyle: AppTypoGraphy.errorHintStyle
          ),

      validator: (String city) {
        if (city.isEmpty) {
          return "City";
        } else {
          return null;
        }
      },
    );
  }

  Widget registerButton(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: Container(
          // margin: EdgeInsets.only(top: 0.0),
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            gradient: new LinearGradient(
                colors: [AppTheme.appDefaultColor, AppTheme.appDefaultColor],
                begin: const FractionalOffset(0.0, 1.0),
                end: const FractionalOffset(0.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: MaterialButton(
              highlightColor: AppTheme.appDefaultColor,
              splashColor: AppTheme.appDefaultColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 82.0),
                child: Text("Update",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white)),
              ),
              onPressed: () {
                print("Register Button clicked");

                NetworkConnectivity.check().then((internet) {
                  if (internet) {
                    onUpdateButtonPressed();
                  } else {
                    //show network erro

                    Methods.showToast(context, "Check your network");
                  }
                });
              }

              // showInSnackBar("Login button pressed")

              ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white38),
            onPressed: () {
              Navigator.pop(context, true);
            }),
        title: Text(
          "Update Profile",
          style: Theme.of(context).textTheme.button.copyWith(
              color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        elevation: 0,
        backgroundColor: AppTheme.appDefaultColor,
      ),
      body: _buildBody(context),
    );
  }
}
