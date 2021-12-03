import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../configurations/serviceLocator/locator.dart';

class CoverImage extends StatelessWidget {
  final SizeConfig _sizeConfig = locator<SizeConfig>();
  final UiHelper _uiHelper = locator<UiHelper>();
  final String? image;

  CoverImage({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image ?? " ",
      imageBuilder: (context, imageProvider) {
        return Container(
          height: _sizeConfig.blockSizeW * 50,
          width: _sizeConfig.screenW,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: imageProvider,
            ),
          ),
        );
      },
      placeholder: (context, url) => _uiHelper.addShimmer(
        child: Container(
          height: _sizeConfig.blockSizeW * 50,
          width: _sizeConfig.screenW,
        ),
      ),
      errorWidget: (context, url, error) => Container(
        height: _sizeConfig.blockSizeW * 50,
        width: _sizeConfig.screenW,
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
