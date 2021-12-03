import 'package:flutter/material.dart';

import '../../../configurations/serviceLocator/locator.dart';

class MenuCard extends StatelessWidget {
  final UiHelper _uiHelper = locator<UiHelper>();
  final String title;
  final Widget iconFromAsset;
  final Function()? onTap;
  MenuCard({
    Key? key,
    required this.title,
    required this.iconFromAsset,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 2000),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            boxShadow: _uiHelper.boxShadow(),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                iconFromAsset,
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: Theme.of(context).primaryColor.withOpacity(0.6)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
