import 'package:flutter/material.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/config/networkConnectivity.dart';

class FeedBackScreen extends StatefulWidget {
  @override
  _FeedBackScreenState createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final double minValue = 8.0;
  final _feedbackTypeList = <String>["Comments", "Bugs", "Questions"];
 final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _feedbackType = "";

  final TextStyle _errorStyle = TextStyle(
    color: Colors.red,
    fontSize: 16.6,
  );

  @override
  initState() {
    _feedbackType = _feedbackTypeList[0];
    super.initState();
  }
   void showMessageError(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: color,
      content: new Text(
        message,
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      duration: const Duration(seconds: 1),
    ));
  }

  Widget _buildAssetHeader() {
    return Container(
      width: double.maxFinite,
      height: 230.0,
      child: Container(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/feedback.png"),
              fit: BoxFit.cover)),
    );
  }

  Widget _buildCategory() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: minValue * 2, horizontal: minValue * 3),
      child: Row(
        children: <Widget>[
          Text(
            "Select feedback type",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: minValue * 2,
          ),
          Expanded(
              child: Align(
            alignment: Alignment.centerRight,
            child: DropdownButton<String>(
              onChanged: (String type) {
                setState(() {
                  _feedbackType = type;
                });
              },
              hint: Text(
                "$_feedbackType",
                style: TextStyle(fontSize: 16.0),
              ),
              items: _feedbackTypeList
                  .map((type) => DropdownMenuItem<String>(
                        child: Text("$type"),
                        value: type,
                      ))
                  .toList(),
            ),
          ))
        ],
      ),
    );
  }

  Widget _buildName() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: minValue * 3),
      child: TextFormField(
        controller: _nameController,
        // validator: usernameValidator,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            errorStyle: _errorStyle,
            contentPadding:
                EdgeInsets.symmetric(vertical: minValue, horizontal: minValue),
            hintText: 'Full Name',
            labelText: 'Full  Name',
            labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
      ),
    );
  }

  Widget _buildEmail() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: minValue * 3),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.text,
        // validator: validateEmail,
        onChanged: (String value) {},
        // readOnly: true,
        decoration: InputDecoration(
            errorStyle: _errorStyle,
            border: UnderlineInputBorder(),
            contentPadding:
                EdgeInsets.symmetric(vertical: minValue, horizontal: minValue),
            labelText: 'Email',
            labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
      ),
    );
  }

  Widget submitButton(BuildContext context) {
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
                  AppTheme.appDefaultColor,
                  AppTheme.appDefaultColor,
                ],
                begin: const FractionalOffset(0.0, 1.0),
                end: const FractionalOffset(0.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: MaterialButton(
              highlightColor: AppTheme.appBackgroundColorforCard4,
              splashColor: AppTheme.appBackgroundColorforCard1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 82.0),
                child: Text("Post",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white)),
              ),
              onPressed: () async {
                NetworkConnectivity.check().then((internet) {
                  if (internet) {

                    if(_nameController.text==""){
                      showMessageError("Please Enter Name");
                    }else if(_emailController.text==""){

                             showMessageError("Please Enter Email");
                    }else if(_messageController.text==""){
                       showMessageError("Please Enter Message");
                    }else{
 showMessageError("FeedBack Posted");
                    }
                   
                  } else {
                    //show network erro
                   showMessageError( "Check network connection");
                  }
                });

                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => DashboardScreen()));
              }

              // showInSnackBar("Login button pressed")

              ),
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: minValue * 3),
      child: TextFormField(
        controller: _messageController,
        keyboardType: TextInputType.text,
        maxLines: 2,
        decoration: InputDecoration(
            errorStyle: _errorStyle,
            labelText: 'Description',
            contentPadding:
                EdgeInsets.symmetric(vertical: minValue, horizontal: minValue),
            labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        leading: IconButton(
            icon: Icon(Icons.close),
            color: Colors.black87,
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 1,
        title: Text(
          "Leave feedback",
          style: TextStyle(color: Colors.black87),
        ),
        // actions: <Widget>[
        //   FlatButton(onPressed: () => null, child: Text("POST"))
        // ],
      ),
      body: ListView(
        children: <Widget>[
          _buildAssetHeader(),
          _buildCategory(),
          SizedBox(
            height: minValue,
          ),
          _buildName(),
          SizedBox(
            height: minValue * 3,
          ),
          _buildEmail(),
          SizedBox(
            height: minValue * 3,
          ),
          _buildDescription(),
          SizedBox(
            height: minValue * 10,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: submitButton(context),
          ),
        ],
      ),
    );
  }
}
