import 'package:wardrobe/configurations/serviceLocator/locator.dart';
import 'package:flutter/material.dart';

class SimpleAlert {
  final SizeConfig _sizeConfig = locator<SizeConfig>();

  Future codMessage(context, String message) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          contentPadding: EdgeInsets.all(0),
          insetPadding: EdgeInsets.all(30),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(_sizeConfig.blockSizeW * 5),
                child:
                    Text(message, style: Theme.of(context).textTheme.bodyText1),
              ),
            ],
          ),
          actions: [
            Center(
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Okay')),
            )
          ],
        );
      },
    );
  }
}
