import 'package:flutter/material.dart';
import 'package:locteca/config/appTheme.dart';

class CirculerStaticImageView extends StatelessWidget {
  final double height, width;
  final String imageUrl;
  CirculerStaticImageView({this.height, this.width, this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            // border: Border.all(
            //   color: Colors.black12
            // ),
            borderRadius: BorderRadius.all(Radius.circular(55)),
            shape: BoxShape.rectangle,
            image:
                DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.cover),
          ),
        ));
  }
}
