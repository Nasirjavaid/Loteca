import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoundedCornerImageViewWithoutBorderDynamic extends StatelessWidget {
  final double height, width, borderWidth;
  final String imageLink;
  final double cornerRadius;
  RoundedCornerImageViewWithoutBorderDynamic(
      {this.height,
      this.width,
      this.borderWidth,
      this.imageLink,
      this.cornerRadius});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Container(
        width: width,
        height: height,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
          child: CachedNetworkImage(
            imageUrl: imageLink,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(cornerRadius),
                    bottomLeft: Radius.circular(cornerRadius),
                    bottomRight: Radius.circular(cornerRadius),
                    topLeft: Radius.circular(cornerRadius)),
                image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)),
              ),
            ),
            placeholder: (context, url) => Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 14,
                    width: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    )),
              ],
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
