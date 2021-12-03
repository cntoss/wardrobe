import 'package:flutter/material.dart';
import 'package:wardrobe/features/auth/forgot_password/bloc/forgot_password_bloc.dart';

import '../../../../../configurations/serviceLocator/locator.dart';
import '../../../../../global/constants/strings/appStrings/appStrings.dart';
import '../../../../../global/widgets/formWidgets/app_button.dart';
import '../../../../../global/widgets/formWidgets/app_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final SizeConfig _sizeConfig = locator<SizeConfig>();
  final UiHelper _uiHelper = locator<UiHelper>();
  final ForgotPasswordBloc _forgotPasswordBloc = locator<ForgotPasswordBloc>();

  ForgotPasswordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => _uiHelper.hideKeyboard(context),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: _uiHelper.listViewAnimator(
            children: [
              _uiHelper.largeHeight,
              // wardrobeLogo(
              //   height: _sizeConfig.blockSizeH * 7,
              //   width: _sizeConfig.blockSizeH * 7,
              // ),
              Padding(
                padding: EdgeInsets.all(_sizeConfig.blockSizeH),
                child: Text("Forgot Password",
                    style: Theme.of(context).textTheme.headline5),
              ),
              Center(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: _sizeConfig.blockSizeH),
                  child: Text(
                    UserAuthStrings.forgotPasswordDescription,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
              _uiHelper.mediumHeight,
              AppTextField(
                labelText: UserAuthStrings.email,
                stream: _forgotPasswordBloc.email,
                onChangeParams: _forgotPasswordBloc.changeEmail,
                prefixIcon: Icon(Icons.email_outlined),
              ),
              AppButton(
                  stream: _forgotPasswordBloc.emailValid,
                  title: ButtonStrings.send,
                  act: () async {
                    try {
                      _uiHelper.hideKeyboard(context);
                      _uiHelper.showLoader(context);
                      _uiHelper.showToast(
                          msg: await _forgotPasswordBloc.forgotPassword());

                      Navigator.pop(context); // For poping Loader
                      Navigator.pop(context);
                    } catch (e) {
                      _uiHelper.showToast(msg: e.toString().toString());
                      Navigator.pop(context);
                    }
                  }),
            ],
          ),
        ),
      ),
    ));
  }
}
