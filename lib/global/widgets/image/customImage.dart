import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../configurations/serviceLocator/locator.dart';

class CustomImage extends StatelessWidget {
  final UiHelper _uiHelper = locator<UiHelper>();
  final String? image;
  final double? height;
  final double? width;
  final BoxFit? fit;

  CustomImage({Key? key, this.image, this.height, this.width, this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image ?? " ",
      imageBuilder: (context, imageProvider) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: fit,
              image: imageProvider,
            ),
          ),
        );
      },
      placeholder: (context, url) => _uiHelper.addShimmer(
        child: Container(
          height: height,
          width: width,
        ),
      ),
      errorWidget: (context, url, error) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          image: DecorationImage(
            image: AssetImage('assets/images/logo.png'),
          ),
        ),
      ),
    );
  }
}
