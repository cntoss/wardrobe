import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function() onTap;
  final PreferredSizeWidget appBar;

  const CustomAppBar({Key? key, required this.onTap, required this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(onTap: onTap, child: appBar);
  }

  @override
  Size get preferredSize =>  const Size.fromHeight(kToolbarHeight);
}