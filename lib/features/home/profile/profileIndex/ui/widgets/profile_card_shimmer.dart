import 'package:flutter/material.dart';

import '../../../../../../configurations/serviceLocator/locator.dart';

class ProfileCardShimmer extends StatelessWidget {
  final SizeConfig _sizeConfig = locator<SizeConfig>();
  final UiHelper _uiHelper = locator<UiHelper>();
  @override
  Widget build(BuildContext context) {
    return _uiHelper.addShimmer(
      child: Padding(
        padding: EdgeInsets.all(_sizeConfig.blockSizeH),
        child: Container(
          padding: EdgeInsets.all(_sizeConfig.blockSizeH),
          height: _sizeConfig.blockSizeW * 55,
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(_sizeConfig.blockSizeH * 2),
              boxShadow: _uiHelper.boxShadow()),
        ),
      ),
    );
  }
}
