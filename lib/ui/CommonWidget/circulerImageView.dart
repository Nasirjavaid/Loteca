import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:locteca/config/appTheme.dart';


class CirculerImageView extends StatelessWidget {
  final double height, width;
  final String imageUrl;
  CirculerImageView({this.height, this.width,this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
                        border: Border.all(
                color: AppTheme.appDefaultColor,
                width: 2,
              ),
              shape: BoxShape.circle,

              //  borderRadius: BorderRadius.circular(500),
              image: DecorationImage(
                image: imageProvider,
             fit: BoxFit.contain,
                //fit: BoxFit.cover,
                
                // colorFilter: ColorFilter.mode(
                //     Colors.black12, BlendMode.colorBurn)
              ),
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
        ));
  }
}
