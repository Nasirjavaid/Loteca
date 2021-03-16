import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locteca/model/agentsToBuyCoins.dart';
import 'package:locteca/ui/CommonWidget/roundedImageViewWithoutBorderDynamic.dart';
import 'package:url_launcher/url_launcher.dart';


class AgentDetailDialogue extends StatelessWidget {
final Agents agents;
  AgentDetailDialogue({this.agents});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Card(
              elevation: 2,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.6),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(3),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RoundedCornerImageViewWithoutBorderDynamic(
                          height: MediaQuery.of(context).size.height * 0.19,
                          width: 120,
                           imageLink: agents.image == null || agents.image == ""
                                ? "https://cdn.pixabay.com/photo/2018/08/26/23/55/woman-3633737__340.jpg"
                                : agents.image,
                          cornerRadius: 10,
                          borderWidth: 1.0,
                        ),
                        // Avatar(
                        //   circleShow: false,
                        //   circleColor: Colors.amber,
                        //   circleHeight: 22,
                        //   circleWidth: 22,
                        //   height: 90,
                        //   width: 90,
                        //   imageUrl:
                        //       "https://cdn.pixabay.com/photo/2018/08/26/23/55/woman-3633737__340.jpg",
                        //   radius: 40,
                        //   backgroundColor: Colors.white,
                        //   borderColor: Colors.grey.shade300,
                        //   borderWidth: 4.0,
                        // ),

                        SizedBox(
                          width: 14,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                               agents.name == null || agents.name ==""? "Agent Name" : agents.name ,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                      fontSize: 12.5,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              "Per coin rate :  N/A",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    color: Colors.black45,
                                    fontSize: 10
                                  ),
                            ),
                             SizedBox(
                              height: 2,
                            ),
                            Text(
                               "Total avilable Coins: ${ agents.coins == null ||  agents.coins == "" ? "" :  agents.coins}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    color: Colors.black45,
                                    fontSize: 10
                                  ),
                            ),
                             SizedBox(
                              height: 2,
                            ),
                            Text(
                         agents.contacts.length !=0  ? "Phone : ${agents.contacts[0].phone == null ||  agents.contacts[0].phone == "" ? "" :  agents.contacts[0].phone}":"",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    color: Colors.black45,
                                    fontSize: 10
                                  ),
                            ),
                            Spacer(),
                            buttons(context,agents)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buttons(BuildContext context,Agents agents) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buttonCall(Icons.call_outlined, Colors.blue[500], Colors.white,agents.contacts[0].phone),
          buttonWhatsApp(Icons.call_outlined, Colors.green[500], Colors.white,agents.contacts[0].whatsapp),
          buttonEmail(Icons.mail_outline, Colors.red[500], Colors.white,agents.contacts[0].email)
        ],
      ),
    );
  }

  Widget buttonCall(IconData myIcon, Color bgColor, Color iconColor,String phoneNumber) {
    return Container(
      height:40,
      width: 40,
      alignment: Alignment.center,
      child: FloatingActionButton(
        elevation: 1,
        backgroundColor: bgColor,
        child: Icon(
          FontAwesomeIcons.phone,
          size: 16,
          color: iconColor,
        ),
        onPressed: () {
          _callMe(phoneNumber);
        },
      ),
    );
  }
    Widget buttonEmail(IconData myIcon, Color bgColor, Color iconColor,String emailAddress) {
    return Container(
      height: 40,
      width: 40,
      alignment: Alignment.center,
      child: FloatingActionButton(
        elevation: 1,
        backgroundColor: bgColor,
        child: Icon(
          Icons.email,
          size: 16,
          color: iconColor,
        ),
        onPressed: () {
          _launchURLEmail(emailAddress);
        },
      ),
    );
  }

    Widget buttonWhatsApp(IconData myIcon, Color bgColor, Color iconColor,String phoneNumber) {
    return Container(
      height: 40,
      width: 40,
      alignment: Alignment.center,
      child: FloatingActionButton(
        elevation: 1,
        backgroundColor: bgColor,
        child: Icon(
          FontAwesomeIcons.whatsapp,
          size: 16,
          color: iconColor,
        ),
        onPressed: () {
               FlutterOpenWhatsapp.sendSingleMessage(phoneNumber, "Hi, I want To Buy Coins !");
        },
      ),
    );
  }



    _callMe(String phioneNumber) async {
    // Android
    var uri = 'tel:$phioneNumber';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      var uri = 'tel:$phioneNumber';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }


  void _launchURLEmail(String emailAddress) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: emailAddress,

    );
    String  url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print( 'Could not launch $url');
    }
  }
}
