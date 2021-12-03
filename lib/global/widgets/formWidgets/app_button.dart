import 'package:flutter/material.dart';

import '../../../configurations/serviceLocator/locator.dart';

// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  SizeConfig _sizeConfig = locator<SizeConfig>();
  final String title;
  final double? height;
  final initialData;
  final double? width;
  final double? padding;
  final VoidCallback? act;
  final Color? color;
  final stream;
  // not required if initialData is true, cause the button will be enabled by default

  AppButton({
    required this.title,
    required this.act,
    this.stream,
    this.height,
    this.width,
    this.padding,
    this.color,
    this.initialData,
  });

  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      initialData: initialData,
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<Object> snapshot) {
        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: _sizeConfig.blockSizeH * 1.5,
              horizontal: padding ?? _sizeConfig.blockSizeH * 1.5),
          child: ButtonTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_sizeConfig.blockSizeW * 2),
            ),
            child: Container(
              height: height ?? _sizeConfig.blockSizeW * 12,
              width: width ?? _sizeConfig.screenW,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(_sizeConfig.blockSizeH * 2)),
                  primary: snapshot.hasData
                      ? snapshot.data != null
                          ? color != null
                              ? color
                              : Theme.of(context).primaryColor
                          : Theme.of(context).disabledColor
                      : Theme.of(context).disabledColor,
                ),
                onPressed: snapshot.hasData
                    ? snapshot.data != null
                        ? act
                        : null
                    : null,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white),
                ),
                //padding: EdgeInsets.all(0.0),
                /*  child: Ink(
                  decoration: snapshot.hasData
                      ? snapshot.data != null
                          ? BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              // gradient: LinearGradient(
                              //   colors: [
                              //     Theme.of(context).colorScheme.secondary,
                              //     Theme.of(context).colorScheme.primary,
                              //   ],
                              //   begin: Alignment.centerLeft,
                              //   end: Alignment.centerRight,
                              // ),
                              borderRadius: BorderRadius.circular(
                                  _sizeConfig.blockSizeH * 2),
                            )
                          : BoxDecoration(
                              color: Theme.of(context).disabledColor,
                              borderRadius: BorderRadius.circular(
                                  _sizeConfig.blockSizeH * 2),
                            )
                      : BoxDecoration(
                          color: Theme.of(context).disabledColor,
                          borderRadius:
                              BorderRadius.circular(_sizeConfig.blockSizeH * 2),
                        ),
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: _sizeConfig.screenW,
                        minHeight: _sizeConfig.blockSizeH * 5.5),
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ), */
              ),
            ),
          ),
        );
      },
    );
  }
}
