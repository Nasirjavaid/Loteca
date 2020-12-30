import 'package:flutter/material.dart';

class RoundedCornerImageView extends StatelessWidget {
final double height,width,borderWidth;
  RoundedCornerImageView({this.height,this.width,this.borderWidth});
  @override
  Widget build(BuildContext context) {
    return Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: borderWidth),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: AssetImage('assets/images/table.jpg'),
                            fit: BoxFit.cover),
                      ),
                    );
  }
}