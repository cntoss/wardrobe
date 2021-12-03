import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WardrobeLogo extends StatelessWidget {
  final double height;
  final double width;
  final double padding;

  const WardrobeLogo(
      {Key? key, this.height = 100, this.width = 100, this.padding = 20})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "WardrobeLogo",
      child: Padding(
        padding: EdgeInsets.all(padding),
         child: const FlutterLogo()
       /*  child: Image.asset(
          'assets/images/logo.png',
          height: height,
          width: width,
        ), */
      ),
    );
  }
}
