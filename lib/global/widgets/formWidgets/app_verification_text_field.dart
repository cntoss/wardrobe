import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../configurations/serviceLocator/locator.dart';
import '../../../configurations/theme/size_config.dart';

class AppVerificationTextField extends StatelessWidget {
  final Stream<Object>? stream;
  final void Function(String) onChangeParams;
  final int? fieldLength;

  final SizeConfig _sizeConfig = locator<SizeConfig>();
  final UiHelper _uiHelper = locator<UiHelper>();

  AppVerificationTextField(
      {Key? key, this.stream, required this.onChangeParams, this.fieldLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: stream,
        builder: (context, snapshot) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PinCodeTextField(
                keyboardType: TextInputType.number,
                onChanged: onChangeParams,
                onCompleted: (value) {
                  _uiHelper.hideKeyboard(context);
                },
                cursorColor: Colors.transparent,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.circle,
                  fieldHeight: _sizeConfig.blockSizeH * 10,
                  fieldWidth: _sizeConfig.blockSizeH * 7,
                  borderWidth: _sizeConfig.blockSizeH * 0.4,
                  activeFillColor: Theme.of(context).primaryColor,
                  inactiveColor: Theme.of(context).primaryColor,
                  inactiveFillColor: Theme.of(context).primaryColor,
                  selectedColor: Theme.of(context).colorScheme.secondary,
                ),
                animationType: AnimationType.scale,
                backgroundColor: Colors.transparent,
                appContext: context,
                length: fieldLength ?? 6,
              ),
              snapshot.hasError
                  ? Text(snapshot.error as String,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Theme.of(context).errorColor))
                  : Container()
            ],
          );
        });
  }
}
