import 'package:flutter/material.dart';
import 'package:locteca/ui/CommonWidget/roundedImageViewWithoutBorderDynamic.dart';


class AgentDetailDialogue extends StatelessWidget {
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
                          imageLink:
                              "https://cdn.pixabay.com/photo/2018/08/26/23/55/woman-3633737__340.jpg",
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
                              "Agent Name",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                      fontSize: 18,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              "Per coin rate : \$5",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                    color: Colors.black45,
                                  ),
                            ),
                            Text(
                              "Total avilable Coins: 267",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                    color: Colors.black45,
                                  ),
                            ),
                            Text(
                              "Address : Temple Road  GT# 12",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                    color: Colors.black45,
                                  ),
                            ),
                            Spacer(),
                            buttons(context)
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

  Widget buttons(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          button(Icons.call_outlined, Colors.blue[500], Colors.white),
          button(Icons.call_outlined, Colors.green[500], Colors.white),
          button(Icons.mail_outline, Colors.red[500], Colors.white)
        ],
      ),
    );
  }

  Widget button(IconData myIcon, Color bgColor, Color iconColor) {
    return Container(
      height: 45,
      width: 45,
      alignment: Alignment.center,
      child: FloatingActionButton(
        elevation: 6,
        backgroundColor: bgColor,
        child: Icon(
          myIcon,
          size: 20,
          color: iconColor,
        ),
        onPressed: () {
          print("Cliked");
        },
      ),
    );
  }
}
