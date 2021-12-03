import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wardrobe/global/constants/images/logo.dart';

import '../../../../../configurations/router/router.dart';
import '../../../../../configurations/serviceLocator/locator.dart';
import '../../../../../global/constants/strings/appStrings/appStrings.dart';
import '../../../../../global/widgets/formWidgets/app_button.dart';
import '../../../../../global/widgets/formWidgets/app_text_button.dart';
import '../../../../../global/widgets/formWidgets/app_text_field.dart';
import '../../../../../global/widgets/formWidgets/intl_phone_field.dart';
import '../../../../../global/widgets/formWidgets/social_button.dart';
import '../../../../../packages/intlField/phone_number.dart';

class LoginScreen extends StatefulWidget {
  final bool? routeToSplash;
  final Function? onRouteFunction;

  const LoginScreen({Key? key, this.routeToSplash = true, this.onRouteFunction})
      : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final SizeConfig _sizeConfig = locator<SizeConfig>();

  final UiHelper _uiHelper = locator<UiHelper>();

  final LoginBloc _loginBloc = locator<LoginBloc>();
  final SplashBloc _splashBloc = locator<SplashBloc>();

  final Duration _duration = const Duration(milliseconds: 800);

  @override
  void dispose() {
    apiCalls();
    super.dispose();
  }

  apiCalls() async {
    await _splashBloc.wishAndCartApiCalls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
          onTap: () => _uiHelper.hideKeyboard(context),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: _uiHelper.listViewAnimator(
              children: [
                _uiHelper.largeHeight,
                WardrobeLogo(
                  height: _sizeConfig.blockSizeH * 7,
                  width: _sizeConfig.blockSizeH * 7,
                ),
                _uiHelper.largeHeight,
                _emailOrPhoneTextField,
                _passwordTextField,
                //_uiHelper.smallHeight,
                _button,
                _forgotPasswordLinkText(context),
                _uiHelper.largeHeight,
                _orDivider(context),
                _buildSignUpRow(context),
                _registerLinkText(context),
                _uiHelper.largeHeight,
              ],
            ),
          ),
        ));
  }

  StreamBuilder<bool> get _button {
    return StreamBuilder<bool>(
      stream: _loginBloc.changeField,
      builder: (BuildContext context, AsyncSnapshot<bool> changeFieldSnapshot) {
        if (changeFieldSnapshot.hasData) {
          return StreamBuilder<bool>(
            initialData: changeFieldSnapshot.data,
            stream: _loginBloc.next,
            builder: (BuildContext context, AsyncSnapshot<bool> nextSnapshot) {
              return Tooltip(
                message:
                    "You must enter correct information to enable the button.",
                child: AppButton(
                  title: nextSnapshot.data!
                      ? ButtonStrings.login
                      : ButtonStrings.next,
                  stream: changeFieldSnapshot.data!
                      ? _loginBloc.emailValid
                      : _loginBloc.phoneValid,
                  act: () async {
                    _uiHelper.hideKeyboard(context);
                    _uiHelper.showLoader(context);
                    try {
                      if (nextSnapshot.data!) {
                        final val = await _loginBloc.login();
                        _uiHelper.showToast(msg: val);
                        Navigator.pop(context);
                        widget.routeToSplash ?? false
                            ? Navigator.pushNamedAndRemoveUntil(
                                context, splash, (route) => false)
                            : Navigator.pop(context);
                      } else {
                        final val = await _loginBloc.emailOrPhoneValidate();

                        _uiHelper.showToast(msg: val);
                        Navigator.pop(context);
                        _loginBloc.changeNext;
                      }
                    } catch (e) {
                      if (e is String) {
                        _uiHelper.showToast(msg: e.toString());
                      } else {
                        _uiHelper.showToast(msg: e.toString()); //v2 e.message
                      }
                      Navigator.pop(context);
                    }
                  },
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  StreamBuilder<bool> get _emailOrPhoneTextField {
    return StreamBuilder<bool>(
        initialData: _loginBloc.fieldValue,
        stream: _loginBloc.changeField,
        builder:
            (BuildContext context, AsyncSnapshot<bool> changeFieldSnapshot) {
          return StreamBuilder(
              initialData: _loginBloc.nextValue,
              stream: _loginBloc.next,
              builder: (BuildContext context,
                  AsyncSnapshot<bool> changeNextSnapshot) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    changeFieldSnapshot.data!
                        ? AppTextField(
                            readOnly: !changeNextSnapshot.data!,
                            labelText: UserAuthStrings.email,
                            prefixIcon: Icon(Icons.email_outlined),
                            stream: _loginBloc.email,
                            onChangeParams: _loginBloc.changeEmail,
                            keyboardType: TextInputType.emailAddress,
                          )
                        : AppIntlTextField(
                            readOnly: !changeNextSnapshot.data!,
                            prefixIcon: Icon(Icons.phone_android_rounded),
                            labelText: UserAuthStrings.phoneNo,
                            keyboardType: TextInputType.phone,
                            stream: _loginBloc.phoneNo,
                            onChangeParams: (PhoneNumber phoneNumber) {
                              _loginBloc
                                  .changeCountryCode(phoneNumber.countryCode);
                              _loginBloc.changePhone(phoneNumber.number);
                            }),
                    changeNextSnapshot.data!
                        ? Positioned(
                            bottom: -_sizeConfig.blockSizeW * 2,
                            right: _sizeConfig.blockSizeH,
                            child: _notYou(),
                          )
                        : Container()
                  ],
                );
              });
        });
  }

  AppTextButton _notYou() {
    return AppTextButton(
      title: UserAuthStrings.notYou,
      onTap: () async {
        _loginBloc.changeNext;
      },
    );
  }

  StreamBuilder<bool> get _passwordTextField {
    return StreamBuilder<bool>(
        initialData: _loginBloc.nextValue,
        stream: _loginBloc.next,
        builder: (BuildContext context, AsyncSnapshot<bool> nextSnapshot) {
          return AnimatedOpacity(
            opacity: nextSnapshot.data! ? 1 : 0,
            duration: _duration,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: double.infinity,
              curve: Curves.linear,
              alignment: Alignment.topCenter,
              height: nextSnapshot.data! ? _sizeConfig.blockSizeH * 12 : 0.2,
              child: Stack(
                children: [
                  AppTextField(
                    labelText: UserAuthStrings.password,
                    stream: _loginBloc.password,
                    onChangeParams: _loginBloc.changePassword,
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                    isPassword: true,
                  ),
                  !_loginBloc.fieldValue
                      ? Positioned(
                          bottom: -_sizeConfig.blockSizeW,
                          right: _sizeConfig.blockSizeH,
                          child: _loginByOTP(),
                        )
                      : Container()
                ],
              ),
            ),
          );
        });
  }

  StreamBuilder _loginByOTP() {
    return StreamBuilder<Object>(
        stream: _loginBloc.loginBy,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return AppTextButton(
              title: UserAuthStrings.loginByOTP,
              onTap: () async {
                _uiHelper.showLoader(context);
                try {
                  await _loginBloc.loginPhoneOTP(
                    context: context,
                    verificationCompleted:
                        (PhoneAuthCredential phoneAuthCredential) async {
                      final _userCredential = await _loginBloc
                          .firebase.firebaseAuthInstance
                          .signInWithCredential(phoneAuthCredential);
                      final User? _user = _userCredential.user;
                      if (_user != null) {
                        try {
                          _uiHelper.showToast(msg: UserAuthStrings.autoAuthOTP);
                          final val = await _loginBloc.otpLogin(_user.uid);
                          _uiHelper.showToast(msg: val);
                          Navigator.pop(context);
                          widget.routeToSplash ?? false
                              ? Navigator.pushNamedAndRemoveUntil(
                                  context, splash, (route) => false)
                              : Navigator.pop(context);
                        } catch (e) {
                          _uiHelper.showToast(msg: e.toString());
                          Navigator.pop(context);
                        }
                      }
                    },
                    codeSent: (String verificationId, int? forceToken) async {
                      Map<String, dynamic> _arguments = {
                        "verificationId": verificationId,
                        "forceToken": forceToken,
                        "isPhone": !snapshot.data,
                        "fromRegister": false,
                        'phoneNo': _loginBloc.phoneValue,
                        'email': _loginBloc.emailValue,
                        'countryCode': _loginBloc.countryCodeValue,
                      };
                      final _uid = await Navigator.pushNamed(
                        context,
                        phonePinVerification,
                        arguments: _arguments,
                      );
                      if (_uid != null) {
                        try {
                          final val = await _loginBloc.otpLogin(_uid as String);
                          _uiHelper.showToast(msg: val);
                          Navigator.pop(context);
                          widget.routeToSplash ?? false
                              ? Navigator.pushNamedAndRemoveUntil(
                                  context, splash, (route) => false)
                              : Navigator.pop(context);
                        } catch (e) {
                          _uiHelper.showToast(msg: e.toString());
                          Navigator.pop(context);
                        }
                      }
                    },
                  );
                } catch (e) {
                  _uiHelper.showToast(msg: e.toString());
                  Navigator.pop(context);
                }
              },
            );
          } else {
            return Container();
          }
        });
  }

  Align _forgotPasswordLinkText(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(right: _sizeConfig.blockSizeH * 3),
        child: AppTextButton(
          title: UserAuthStrings.forgotPassword,
          onTap: () => Navigator.pushNamed(
            context,
            forgotPassword,
          ),
        ),
      ),
    );
  }

  Stack _orDivider(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _sizeConfig.blockSizeH * 7),
          child: Divider(
            color: Colors.black38,
          ),
        ),
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: _sizeConfig.blockSizeH),
            color: Theme.of(context).colorScheme.background,
            child: Text(
              UserAuthStrings.or,
            ),
          ),
        )
      ],
    );
  }

  Center _registerLinkText(context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(_sizeConfig.blockSizeH * 2),
        child: AppTextButton(
          padding: _sizeConfig.blockSizeH * 4,
          title: UserAuthStrings.registerHere,
          onTap: () => Navigator.pushNamed(context, register),
        ),
      ),
    );
  }

  Container _buildSignUpRow(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Tooltip(
              message: UserAuthStrings.byFacebook,
              child: SocialButton(
                icon: FontAwesomeIcons.facebookF,
                color: Color(0xff3b5998),
                onTap: () async {
                  _uiHelper.hideKeyboard(context);
                  _uiHelper.showLoader(context);
                  try {
                    final message = await _loginBloc.facebookLogin();
                    Navigator.pop(context);
                    widget.routeToSplash ?? false
                        ? Navigator.pushNamedAndRemoveUntil(
                            context, splash, (route) => false)
                        : Navigator.pop(context);

                    _uiHelper.showToast(msg: message);
                  } catch (e) {
                    if (e is String) {
                      _uiHelper.showToast(msg: e);
                    } else {
                      _uiHelper.showToast(msg: e.toString());
                    }
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ),
          StreamBuilder<bool>(
              initialData: _loginBloc.fieldValue,
              stream: _loginBloc.changeField,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                return Tooltip(
                  message: UserAuthStrings.byPhone,
                  child: SocialButton(
                      color: Theme.of(context).primaryColor,
                      icon: snapshot.data!
                          ? Icons.phone_android_rounded
                          : Icons.email_outlined,
                      onTap: () {
                        _loginBloc.changeFieldValue;
                        _loginBloc.setNextToFalse;
                        _loginBloc.changeLoginBy;
                      }),
                );
              }),
          Tooltip(
            message: UserAuthStrings.byGoogle,
            child: SocialButton(
                icon: FontAwesomeIcons.google,
                color: Color(0xff4285F4),
                onTap: () async {
                  _uiHelper.hideKeyboard(context);
                  _uiHelper.showLoader(context);
                  try {
                    final message = await _loginBloc.googleLogin();
                    Navigator.pop(context);
                    widget.routeToSplash ?? false
                        ? Navigator.pushNamedAndRemoveUntil(
                            context, splash, (route) => false)
                        : Navigator.pop(context);

                    _uiHelper.showToast(msg: message);
                  } catch (e) {
                    if (e is String) {
                      _uiHelper.showToast(msg: e);
                    } else {
                      _uiHelper.showToast(msg: e.toString());
                    }
                    Navigator.pop(context);
                  }
                }),
          ),
          if (Platform.isIOS)
            Flexible(
              child: Tooltip(
                padding: EdgeInsets.all(0),
                message: UserAuthStrings.byApple,
                child: SocialButton(
                    icon: FontAwesomeIcons.apple,
                    color: Color(0xffA2AAAD),
                    onTap: () async {
                      _uiHelper.hideKeyboard(context);
                      _uiHelper.showLoader(context);
                      try {
                        final message = await _loginBloc.appleLogin();
                        Navigator.pop(context);
                        widget.routeToSplash ?? false
                            ? Navigator.pushNamedAndRemoveUntil(
                                context, splash, (route) => false)
                            : Navigator.pop(context);

                        _uiHelper.showToast(msg: message);
                      } catch (e) {
                        if (e is String) {
                          _uiHelper.showToast(msg: e);
                        } else {
                          _uiHelper.showToast(msg: e.toString());
                        }
                        Navigator.pop(context);
                      }
                    }),
              ),
            ),
        ],
      ),
    );
  }
}
