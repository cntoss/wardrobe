import 'package:flutter/material.dart';

class ProfileOrderCard extends StatelessWidget {
  final String title;
  final Widget iconFromAsset;
  final Function()? onTap;
  ProfileOrderCard({
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              iconFromAsset,
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Theme.of(context).accentColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
