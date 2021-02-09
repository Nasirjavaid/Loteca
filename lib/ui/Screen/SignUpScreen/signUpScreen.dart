import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/signUpBloc/signUpBloc.dart';
import 'package:locteca/bloc/signUpBloc/signUpEvent.dart';
import 'package:locteca/bloc/signUpBloc/signUpSate.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/config/networkConnectivity.dart';
import 'package:locteca/ui/CommonWidget/commonWidgets.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocProvider(
            create: (context) => SignUpBloc(), child: SignUpScreenMain()));
  }
}

class SignUpScreenMain extends StatefulWidget {
  @override
  _SignUpScreenMainState createState() => _SignUpScreenMainState();
}

class _SignUpScreenMainState extends State<SignUpScreenMain> {
  // UserAuthRepository userAuthRepository = UserAuthRepository();

  TextEditingController etUserName = TextEditingController();
  TextEditingController etEmail = TextEditingController();
  TextEditingController etMobile = TextEditingController();
  TextEditingController etWhatsAppNumber = TextEditingController();
  TextEditingController etAddres = TextEditingController();
  TextEditingController etPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int roleType = 1;

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

  onRegisterButtonPressed() {
    BlocProvider.of<SignUpBloc>(context).add(SignUpButtonPressed(
        etUserName.text, etEmail.text, etMobile.text,etWhatsAppNumber.text, etPassword.text, roleType.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        //title: Text("Register", style: Theme.of(context).textTheme.button),
      ),
      body: buidBody(context),
    ));
  }

  Widget buidBody(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(listener: (context, state) {
      if (state is SignUpFailure) {
        _showToast(context, "${state.error}");
      }
      if (state is SignUpInProgress) {
        return Center(
          child: CommonWidgets.progressIndicator,
        );
      }
      if (state is SignUpInSuccess) {
        _showToast(context, "${state.message}");
        etUserName.text = "";
        etEmail.text = "";
        etPassword.text = "";
        etMobile.text = "";
        etWhatsAppNumber.text = "";
        etAddres.text = "";
      }
      if (state is SignUpSuccessAndGoToLoginScreen) {
        Navigator.pop(context);
      }
    }, child: BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Flex(
            direction: Axis.vertical,
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Column(
                children: [
                  topClipper(context),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: dynamicText(context, "Sign Up"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: firstNameInputField(context),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: emailInputField(context),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: phoneInputField(context),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: whatsAppPhoneInputField(context),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: passwordInputField(context),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  userTypeRadioButtons(context),
                  // passwordRepeatInputField(context),
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
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  //   child: phoneNumberInputField(context),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  //   child: addressInputField(context),
                  // ),
                  SizedBox(
                    height: 40,
                  ),
                  // zipCodeInputField(context),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // cityInputField(context),
                  // SizedBox(
                  //   height: 40,
                  // ),
                  state is SignUpInProgress
                      ? CommonWidgets.progressIndicator
                      : registerButton(context),
                  SizedBox(
                    height: 20,
                  ),
                  loginText(context),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: bottomClipper(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }));
  }

  Widget dynamicText(BuildContext context, String dynamicText) {
//return Text("FORGOT PASSWORD?", style:  GoogleFonts.lato());
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Text("$dynamicText",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.button.copyWith(
              color: AppTheme.appDefaultColor,
              fontSize: 20,
              fontWeight: FontWeight.w800)),
    );
  }

  Widget emailInputField(BuildContext context) {
    return TextFormField(
      controller: etEmail,
      keyboardType: TextInputType.emailAddress,
      //textCapitalization: TextCapitalization.words,
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
  Widget phoneInputField(BuildContext context) {
    return TextFormField(
      controller: etMobile,
      keyboardType: TextInputType.phone,
      //textCapitalization: TextCapitalization.words,
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
          labelText: "Phone Number",
          labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w600, color: Colors.black38, fontSize: 14)

          // errorStyle: AppTypoGraphy.errorHintStyle
          ),

      validator: (String userName) {
        if (userName.isEmpty) {
          return "Phone Number";
        } else {
          return null;
        }
      },
    );
  }
  Widget whatsAppPhoneInputField(BuildContext context) {
    return TextFormField(
      controller: etWhatsAppNumber,
      keyboardType: TextInputType.phone,
      //textCapitalization: TextCapitalization.words,
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
          labelText: "WhatsApp Number",
          labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w600, color: Colors.black38, fontSize: 14)

          // errorStyle: AppTypoGraphy.errorHintStyle
          ),

      validator: (String userName) {
        if (userName.isEmpty) {
          return "WhatsApp Number";
        } else {
          return null;
        }
      },
    );
  }

  Widget passwordInputField(BuildContext context) {
    return TextFormField(
      controller: etPassword,
      keyboardType: TextInputType.text,
      obscureText: true,
     // textCapitalization: TextCapitalization.words,
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
          labelText: "Password",
          labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w600, color: Colors.black38, fontSize: 14)

          // errorStyle: AppTypoGraphy.errorHintStyle
          ),

      validator: (String password) {
        if (password.isEmpty) {
          return "Password";
        } else {
          return null;
        }
      },
    );
  }

  Widget userTypeRadioButtons(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.35,
            child: ListTile(
              title: const Text('Player'),
              leading: Radio(
                value: 1,
                groupValue: roleType,
                onChanged: (value) {
                  setState(() {
                    roleType = value;
                  });
                },
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.35,
            child: ListTile(
              title: const Text('Agent'),
              leading: Radio(
                value: 2,
                groupValue: roleType,
                onChanged: (value) {
                  setState(() {
                    roleType = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget passwordRepeatInputField(BuildContext context) {
    return TextFormField(
      // controller: _usernameController,
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
          labelText: "Repeat Password",
          labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w600, color: Colors.black38, fontSize: 14)

          // errorStyle: AppTypoGraphy.errorHintStyle
          ),

      validator: (String password) {
        if (password.isEmpty) {
          return "Repeat Password";
        } else {
          return null;
        }
      },
    );
  }

  Widget firstNameInputField(BuildContext context) {
    return TextFormField(
      controller: etUserName,
      keyboardType: TextInputType.text,
     // textCapitalization: TextCapitalization.words,
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
      controller: etAddres,
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
          labelText: "Address",
          labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w600, color: Colors.black38, fontSize: 14)

          // errorStyle: AppTypoGraphy.errorHintStyle
          ),

      validator: (String address) {
        if (address.isEmpty) {
          return "Address";
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
                colors: [
                  AppTheme.appCardColor,
                  AppTheme.appCardColor,
                ],
                begin: const FractionalOffset(0.0, 1.0),
                end: const FractionalOffset(0.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: MaterialButton(
              highlightColor: AppTheme.appDefaultButtonSplashColor,
              splashColor: AppTheme.appDefaultButtonSplashColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 82.0),
                child: Text("Register",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white)),
              ),
              onPressed: () {
                print("Register Button clicked");

                NetworkConnectivity.check().then((internet) {
                  if (internet) {
                    onRegisterButtonPressed();
                  } else {
                    //show network erro
                    _showToast(context, "Check Network Conection");
                  }
                });
              }

              // showInSnackBar("Login button pressed")

              ),
        ),
      ),
    );
  }

  Widget loginText(BuildContext context) {
//return Text("FORGOT PASSWORD?", style:  GoogleFonts.lato());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already Have an Account ?",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.black38, fontSize: 12)),
        SizedBox(
          width: 10,
        ),
        InkWell(
          highlightColor: Colors.red[100],
          child: Text("Login here",
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: AppTheme.appCardColor,
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    decorationThickness: 2,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: AppTheme.appCardColor,
                  )),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget bottomClipper(BuildContext context) {
//return Text("FORGOT PASSWORD?", style:  GoogleFonts.lato());
    return Stack(children: [
      ClipPath(
        clipper: OvalTopBorderClipper(),
        child: Container(
          height: 100,
          color: Colors.blue[100].withOpacity(0.5),
          child: Center(child: Text("")),
        ),
      ),
      ClipPath(
        clipper: WaveClipperTwo(reverse: true),
        child: Container(
          height: 100,
          color: Colors.blue[900].withOpacity(0.1),
          child: Center(child: Text("")),
        ),
      ),
      ClipPath(
        clipper: WaveClipperOne(reverse: true),
        child: Container(
          height: 100,
          color: Colors.blue[600].withOpacity(0.1),
          child: Center(child: Text("")),
        ),
      ),
    ]);
  }

  Widget topClipper(BuildContext context) {
//return Text("FORGOT PASSWORD?", style:  GoogleFonts.lato());
    return Stack(children: [
      ClipPath(
        clipper: OvalBottomBorderClipper(),
        child: Container(
          height: 100,
          color: Colors.blue[100].withOpacity(0.7),
          child: Center(child: Text("")),
        ),
      ),
      ClipPath(
        clipper: WaveClipperTwo(reverse: false),
        child: Container(
          height: 170,
          color: Colors.blue[900].withOpacity(0.1),
          child: Center(child: Text("")),
        ),
      ),
      ClipPath(
        clipper: WaveClipperOne(reverse: false),
        child: Container(
          height: 150,
          color: Colors.blue[600].withOpacity(0.1),
          child: Center(child: Text("")),
        ),
      ),
    ]);
  }
}
