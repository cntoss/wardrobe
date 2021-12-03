import 'package:wardrobe/configurations/serviceLocator/locator.dart';
import 'package:flutter/material.dart';

class NoDataText extends StatelessWidget {
  NoDataText({Key? key, required this.title, this.vPadding}) : super(key: key);

  final SizeConfig _sizeConfig = locator<SizeConfig>();
  final String title;
  final double? vPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: vPadding ?? _sizeConfig.safeBlockW * 10),
      child: Center(
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Colors.black54, fontWeight: FontWeight.w100),
        ),
      ),
    );
  }
}
