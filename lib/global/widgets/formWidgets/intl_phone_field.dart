import 'package:flutter/material.dart';

import '../../../configurations/serviceLocator/locator.dart';
import '../../../packages/intlField/intl_phone_field.dart';
import '../../../packages/intlField/phone_number.dart';

class AppIntlTextField extends StatefulWidget {
  final String? hintText;
  final bool isPassword;
  final int maxLines;
  final double? height;
  final String? labelText;
  final String? initialData;

  final bool readOnly;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final Stream<Object> stream;
  final void Function(PhoneNumber) onChangeParams;

  const AppIntlTextField({
    Key? key,
    this.hintText,
    this.isPassword = false,
    this.maxLines = 1,
    this.height,
    this.labelText,
    required this.stream,
    required this.onChangeParams,
    this.prefixIcon,
    required this.keyboardType,
    this.readOnly = true,
    this.initialData,
  }) : super(key: key);

  @override
  _AppIntlTextFieldState createState() => _AppIntlTextFieldState(isPassword);
}

class _AppIntlTextFieldState extends State<AppIntlTextField> {
  SizeConfig _sizeConfig = locator<SizeConfig>();
  bool _isPassword = false;
  _AppIntlTextFieldState(this._isPassword);
  TextEditingController _controller = TextEditingController();

  void initState() {
    _controller.text = widget.initialData ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: widget.stream,
        initialData: widget.initialData,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _sizeConfig.blockSizeH * 3,
              //vertical: _sizeConfig.blockSizeH * 1.5,
            ),
            child: SizedBox(
              width: _sizeConfig.screenW,
              height: _sizeConfig.blockSizeH * 12,
              child: IntlPhoneField(
                enabled: widget.readOnly,
                initialCountryCode: "NP",
                controller: _controller,
                onChanged: widget.onChangeParams,
                obscureText: _isPassword ? true : false,
                style: TextStyle(
                  color: Colors.black,
                ),
                keyboardType: widget.keyboardType,
                decoration: _decoration(snapshot, context),
              ),
            ),
          );
        });
  }

  InputDecoration _decoration(
      AsyncSnapshot<Object> snapshot, BuildContext context) {
    return InputDecoration(
      // enabled: widget.readOnly,
      enabled: false,
      hintText: widget.isPassword ? "" : snapshot.data as String? ?? "",
      helperText: " ",
      isDense: true,
      suffixIcon: this.widget.isPassword ? _passwordEye(context) : null,
      focusColor: Theme.of(context).accentColor,
      prefixIcon: widget.prefixIcon != null ? widget.prefixIcon : null,
      errorText: snapshot.error as String?,
      border: _outlineBorder(context),
      focusedBorder: _focusBorder(context),
      labelText: widget.readOnly ? widget.labelText : snapshot.data as String?,
      labelStyle: Theme.of(context).textTheme.bodyText2,
    );
  }

  OutlineInputBorder _focusBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(_sizeConfig.blockSizeH * 2),
      borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
    );
  }

  OutlineInputBorder _outlineBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(_sizeConfig.blockSizeH * 2),
      borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary),
    );
  }

  Padding _passwordEye(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(_sizeConfig.blockSizeH),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isPassword = !_isPassword;
          });
        },
        child: Icon(
          _isPassword ? Icons.visibility_off : Icons.visibility,
          color: _isPassword
              ? Theme.of(context).disabledColor
              : Theme.of(context).primaryColor,
          size: _sizeConfig.blockSizeH * 3,
        ),
      ),
    );
  }
}
