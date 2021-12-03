import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../configurations/serviceLocator/locator.dart';

class ProfilePicture extends StatelessWidget {
  final SizeConfig _sizeConfig = locator<SizeConfig>();
  final UiHelper _uiHelper = locator<UiHelper>();
  final String? image;
  final double? maxRadius;
  final double? minRadius;
  final bool? shadow;

  ProfilePicture({
    Key? key,
    this.image = " ",
    this.maxRadius = 16,
    this.minRadius = 10,
    this.shadow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image ?? " ",
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: shadow! ? _uiHelper.boxShadow() : [],
            borderRadius: BorderRadius.circular(
              _sizeConfig.blockSizeH * 8,
            ),
          ),
          child: CircleAvatar(
            backgroundColor: Theme.of(context).backgroundColor,
            backgroundImage: imageProvider,
            maxRadius: _sizeConfig.blockSizeW * maxRadius!,
            minRadius: _sizeConfig.blockSizeW * minRadius!,
          ),
        );
      },
      placeholder: (context, url) => _uiHelper.addShimmer(
        child: Container(
          height: _sizeConfig.blockSizeH * maxRadius!,
          width: _sizeConfig.blockSizeH * maxRadius!,
          decoration: BoxDecoration(
            boxShadow: shadow! ? _uiHelper.boxShadow() : [],
            borderRadius: BorderRadius.circular(
              _sizeConfig.blockSizeH * 8,
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(
          boxShadow: shadow! ? _uiHelper.boxShadow() : [],
          borderRadius: BorderRadius.circular(
            _sizeConfig.blockSizeH * 8,
          ),
        ),
        child: CircleAvatar(
          backgroundColor: Theme.of(context).backgroundColor,
          backgroundImage: AssetImage('assets/images/ug_logo.png'),
          maxRadius: _sizeConfig.blockSizeW * maxRadius!,
          minRadius: _sizeConfig.blockSizeW * minRadius!,
        ),
      ),
    );
  }
}
