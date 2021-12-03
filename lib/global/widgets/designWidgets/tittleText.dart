import 'package:wardrobe/configurations/serviceLocator/locator.dart';
import 'package:wardrobe/global/widgets/formWidgets/app_text_button.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  TitleText({Key? key, required this.title, this.onTap}) : super(key: key);

  final _sizeConfig = locator<SizeConfig>();
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: _sizeConfig.blockSizeW * 3,
          vertical: _sizeConfig.blockSizeW * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: Text(title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline1)),
          onTap == null
              ? Container()
              : AppTextButton(
                  title: "View All",
                  onTap: onTap,
                )
        ],
      ),
    );
  }
}
