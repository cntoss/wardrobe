import 'package:flutter/material.dart';

import '../../../configurations/serviceLocator/locator.dart';

class AppTextButton extends StatelessWidget {
  final SizeConfig _sizeConfig = locator<SizeConfig>();
  final Function()? onTap;
  final String title;
  final Color? textColor;
  final double padding;
  final bool textPadding;

  AppTextButton({
    required this.title,
    this.textColor,
    this.onTap,
    this.padding = 0.0,
    this.textPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: textPadding ? 0 : _sizeConfig.blockSizeW * 2,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: textColor ?? Theme.of(context).primaryColor,
                ),
          ),
        ),
      ),
    );
  }
}

//  TextButton(
//           onPressed: onTap,
//           child: Padding(
// padding: EdgeInsets.symmetric(
//   vertical: textPadding ? 0 : _sizeConfig.blockSizeW,
//   horizontal: textPadding ? 0 : _sizeConfig.blockSizeW,
// ),
//             child: Text(
//               title,
//               style: Theme.of(context).textTheme.headline6.copyWith(
//                     color: textColor ?? Theme.of(context).primaryColor,
//                   ),
//             ),
//           ),
//         ),
