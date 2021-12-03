import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../configurations/serviceLocator/locator.dart';

//!Using prefix icon is recommended , without prefix icon the size of the height of textfield must be custom set.
class AppTextField extends StatefulWidget {
  final bool isPassword;
  final int? maxLines;
  final double? height;
  final bool readOnly;
  final String labelText;
  final String? initialData;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final Stream<Object>? stream;
  final Function(String)? onChangeParams;
  final TextEditingController? controller;
  final double padding;
  final String? counterText;
  final String? validateEmpty;
  final bool disable;

const  AppTextField(
      {Key? key,
      this.isPassword = false,
      this.maxLines = 1,
      this.height,
      required this.labelText,
      this.stream,
      this.onChangeParams,
      this.prefixIcon,
      this.keyboardType,
      this.counterText,
      this.readOnly = true,
      this.initialData,
      this.padding = 3,
      this.controller,
      this.validateEmpty,
      this.disable = false})
      : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState(isPassword);
}

class _AppTextFieldState extends State<AppTextField> {
  SizeConfig _sizeConfig = locator<SizeConfig>();
  TextEditingController _controller = TextEditingController();

  bool _isPassword = false;
  _AppTextFieldState(this._isPassword);
  @override
  void initState() {
    _controller.text = widget.initialData ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        initialData: widget.initialData,
        stream: widget.stream,
        builder: (BuildContext context, AsyncSnapshot<Object> snapshot) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _sizeConfig.blockSizeH * widget.padding,
              vertical: _sizeConfig.blockSizeH * 1.5,
            ),
            child: TextFormField(
              controller: widget.controller ?? _controller,
              maxLines: widget.maxLines,
              onChanged: widget.onChangeParams,
              obscureText: _isPassword ? true : false,
              enabled: !widget.disable,
              validator: (value) {
                if (widget.validateEmpty != null) {
                  if (value == null || value == '')
                    return widget.validateEmpty;
                  else
                    return null;
                } else
                  return null;
              },
              style: TextStyle(
                color: Colors.black,
              ),
              inputFormatters: widget.keyboardType == TextInputType.number ||
                      widget.keyboardType == TextInputType.phone
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : [],
              keyboardType: widget.keyboardType,
              cursorColor: Theme.of(context).accentColor,
              decoration: _decoration(snapshot, context),
            ),
          );
        });
  }

  InputDecoration _decoration(
      AsyncSnapshot<Object> snapshot, BuildContext context) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(
        _sizeConfig.blockSizeW * 4,
      ),
      enabled: widget.readOnly,
      hintText: widget.isPassword
          ? ""
          : snapshot.hasData
              ? snapshot.data.toString()
              : " ",
      //helperText: '',
      isDense: true,
      suffixIcon: this.widget.isPassword ? _passwordEye(context) : null,
      focusColor: Theme.of(context).accentColor,
      prefixIcon: widget.prefixIcon != null ? widget.prefixIcon : null,
      errorText: snapshot.hasError ? snapshot.error.toString() : null,
      border: _outlineBorder(context),
      focusedBorder: _focusBorder(context),
      counterText: widget.counterText ?? '',
      counterStyle: Theme.of(context).textTheme.subtitle1,
      labelText: widget.readOnly
          ? widget.labelText
          : snapshot.data.toString() as String?,
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
