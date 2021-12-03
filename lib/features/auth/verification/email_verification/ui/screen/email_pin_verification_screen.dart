import 'package:flutter/material.dart';
import 'package:wardrobe/configurations/serviceLocator/locator.dart';
import 'package:wardrobe/features/auth/verification/email_verification/bloc/email_verification_bloc.dart';
import 'package:wardrobe/global/constants/images/logo.dart';

import '../../../../../../global/constants/strings/appStrings/appStrings.dart'
    show UserAuthStrings, ButtonStrings;
import '../../../../../../global/widgets/formWidgets/app_button.dart';
import '../../../../../../global/widgets/formWidgets/app_verification_text_field.dart';

class EmailPinVerificationScreen extends StatefulWidget {
  final String email;

  EmailPinVerificationScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  _EmailPinVerificationScreenState createState() =>
      _EmailPinVerificationScreenState();
}

class _EmailPinVerificationScreenState
    extends State<EmailPinVerificationScreen> {
  final SizeConfig _sizeConfig = locator<SizeConfig>();

  final UiHelper _uiHelper = locator<UiHelper>();

  final EmailPinVerificationBloc _pinBloc = EmailPinVerificationBloc();

  @override
  dispose() {
    _pinBloc.closeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
          onTap: () => _uiHelper.hideKeyboard(context),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: _uiHelper.listViewAnimator(
              children: [
                _uiHelper.largeHeight,
                _logo,
                _uiHelper.mediumHeight,
                _buildTitle(context),
                _buildSubtitle(context),
                _buildPinField,
                _verifyButton(context),
                // _resendLink
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center _buildSubtitle(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          UserAuthStrings.enterCodeSentTo + widget.email,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }

  Center _buildTitle(BuildContext context) {
    return Center(
      child: Text(
        UserAuthStrings.emailVerification,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  WardrobeLogo get _logo {
    return WardrobeLogo(
      height: _sizeConfig.blockSizeH * 7,
      width: _sizeConfig.blockSizeH * 7,
    );
  }

  AppButton _verifyButton(context) {
    return AppButton(
        title: ButtonStrings.verify,
        stream: _pinBloc.pinValid,
        act: () async {
          try {
            _uiHelper.showLoader(context);
            final _response = await _pinBloc.verifyEmail(widget.email);
            _uiHelper.showToast(msg: _response);
            Navigator.pop(context);
            Navigator.pop(context); //Pop for loader
            //removed splash navigation
          } catch (e) {
            Navigator.pop(context);
            _uiHelper.showToast(msg: e.toString());
          }
        });
  }

  Center get _buildPinField {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(_sizeConfig.blockSizeH * 1.5),
        child: AppVerificationTextField(
          stream: _pinBloc.pin,
          onChangeParams: _pinBloc.changePin,
        ),
      ),
    );
  }
}
