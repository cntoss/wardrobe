import 'package:flutter/material.dart';
import 'package:wardrobe/global/constants/images/logo.dart';

import '../../../../../../configurations/serviceLocator/locator.dart';
import '../../../../../../global/constants/strings/appStrings/appStrings.dart'
    show UserAuthStrings, ButtonStrings;
import '../../../../../../global/widgets/formWidgets/app_button.dart';
import '../../../../../../global/widgets/formWidgets/app_verification_text_field.dart';
import '../../bloc/phone_pin_verification_bloc.dart';

class PhonePinVerificationScreen extends StatefulWidget {
  final String verificationId;
  final int? token;
  final bool isPhone;
  final bool fromRegister;
  final String? countryCode;
  final String phoneNo;
  final String email;

  PhonePinVerificationScreen({
    Key? key,
    this.isPhone = true,
    required this.verificationId,
    this.token,
    this.countryCode,
    required this.phoneNo,
    required this.email,
    this.fromRegister = false,
  }) : super(key: key);

  @override
  _PhonePinVerificationScreenState createState() =>
      _PhonePinVerificationScreenState();
}

class _PhonePinVerificationScreenState
    extends State<PhonePinVerificationScreen> {
  final SizeConfig _sizeConfig = locator<SizeConfig>();

  final UiHelper _uiHelper = locator<UiHelper>();

  final PhonePinVerificationBloc _phonePinBloc =
      locator<PhonePinVerificationBloc>();

  @override
  void initState() {
    // _phonePinBloc.clearValue();
    super.initState();
  }

  @override
  dispose() {
    _phonePinBloc.closeStream();
    super.dispose();
  }

  apiCalls() async {
    await _phonePinBloc.loginByCredential(
        verificationId: widget.verificationId);
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
      child: Text(
        widget.isPhone
            ? UserAuthStrings.enterCodeSentTo + widget.phoneNo
            : UserAuthStrings.enterCodeSentTo + widget.email,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }

  Center _buildTitle(BuildContext context) {
    return Center(
      child: Text(
        widget.isPhone
            ? UserAuthStrings.phoneVerification
            : UserAuthStrings.emailVerification,
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

  StreamBuilder<String> _verifyButton(context) {
    return StreamBuilder<String>(
        stream: _phonePinBloc.uid,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return AppButton(
              title: !snapshot.hasData
                  ? ButtonStrings.verify
                  : ButtonStrings.verified + "!! Click to start shopping!!",
              stream: _phonePinBloc.pinValid,
              act: () async {
                try {
                  _uiHelper.showToast(msg: "Verifying data, please wait....");
                  String? result = await _phonePinBloc.loginByCredential(
                      verificationId: widget.verificationId);
                  if (result != null) {
                    return Navigator.of(context).pop(result);
                  }
                } catch (e) {
                  _uiHelper.showToast(msg: e.toString());
                }
              });
        });
  }

  Center get _buildPinField {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(_sizeConfig.blockSizeH * 1.5),
        child: AppVerificationTextField(
          stream: _phonePinBloc.pin,
          onChangeParams: _phonePinBloc.changePin,
        ),
      ),
    );
  }
}
