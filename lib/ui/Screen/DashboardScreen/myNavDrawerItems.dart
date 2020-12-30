import 'package:flutter/material.dart';


class MyDrawerItems {
  BuildContext context;

  MyDrawerItems(this.context);
  Widget drawerItem({IconData icon, String text, GestureTapCallback onTap}) {
    return SizedBox(
        height: 25,
        child: InkWell(
          child: Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: Row(children: <Widget>[
                    Icon(
                      icon,
                      color: Colors.black54,
                      size: 16,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Text(text,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                    fontSize: 13))),
                  ]))
            ],
          ),
          onTap: onTap,
        ));
  }
}
