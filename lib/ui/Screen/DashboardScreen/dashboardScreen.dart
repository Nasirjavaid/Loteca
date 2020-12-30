import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:locteca/config/appTheme.dart';


class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SingleChildScrollView(child: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              topClipper(context),
              SizedBox(
                height: 30,
              ),
              mainCardWidget(context),
              buttonsCardWidget(context),
              buttomCardForCompanyWidget(context),
              SizedBox(
                height: 30,
              ),

              //bottomClipper(context)
            ],
          ),
        ),
      ],
    );
  }

  Widget mainCardWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12),
      child: Card(
          elevation: 5,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              logoAndSloganWidget(context),
              SizedBox(
                height: 20,
              ),
            ],
          )),
    );
  }

  Widget buttonsCardWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        12.0,
      ),
      child: Card(
        elevation: 5,
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: selectionButtonsWidget(context)),
      ),
    );
  }

  Widget sloganText(BuildContext context) {
    return Text("TrueMed",
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(fontWeight: FontWeight.w600, color: Colors.black87));
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

  Widget logoAndSloganWidget(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
              height: 100,
              width: 100,
              child: Image.asset('assets/images/labhub.png')),
        ),
        SizedBox(height: 20),
        sloganText(context),
      ],
    );
  }

  Widget selectionButtonsWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 20,
        ),
        newOrderButton(context),
        SizedBox(
          height: 15,
        ),
        checkRecordButton(context),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget newOrderButton(BuildContext context) {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: Container(
          // margin: EdgeInsets.only(top: 0.0),
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            gradient: new LinearGradient(
                colors: [
                  AppTheme.drawerBackgroundColor2,
                  AppTheme.drawerBackgroundColor2,
                ],
                begin: const FractionalOffset(0.0, 1.0),
                end: const FractionalOffset(0.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: MaterialButton(
              highlightColor: Colors.blue[300],
              splashColor: Colors.blue[300],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 2.0),
                child: Text("New Order",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white)),
              ),
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => CovidFormScreen()));
              }

              // showInSnackBar("Login button pressed")

              ),
        ),
      ),
    );
  }

  Widget checkRecordButton(BuildContext context) {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: Container(
          // margin: EdgeInsets.only(top: 0.0),
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            gradient: new LinearGradient(
                colors: [
                  AppTheme.drawerBackgroundColor2,
                  AppTheme.drawerBackgroundColor2,
                ],
                begin: const FractionalOffset(0.0, 1.0),
                end: const FractionalOffset(0.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: MaterialButton(
              highlightColor: Colors.blue[300],
              splashColor: Colors.blue[300],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 2.0),
                child: Text("Check Record",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white)),
              ),
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => CheckRecordScreenMain()));
              }

              // showInSnackBar("Login button pressed")

              ),
        ),
      ),
    );
  }

  Widget buttomCardForCompanyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12),
      child: Card(
        elevation: 5,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              // mainAxisSize: MainAxisSize.max,

              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // SizedBox(
                //   width: 10,
                // ),
                Container(
                    height: 70,
                    width: 70,
                    child: Image.asset('assets/images/labhub.png')),
                SizedBox(
                  width: 10,
                ),
                Text("TrueMed Laboratories Pvt Ltd.")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
