import 'package:flutter/material.dart';

import '../../../../../configurations/router/router.dart';
import '../../../../../configurations/serviceLocator/locator.dart';
import '../../../../../global/constants/strings/appStrings/appStrings.dart';
import '../../../../../global/widgets/formWidgets/app_button.dart';
import '../../../../../global/widgets/formWidgets/app_text_button.dart';
import '../../../../../global/widgets/formWidgets/app_text_field.dart';
import '../../../../../global/widgets/formWidgets/date_time_widget.dart';
import '../../../../../global/widgets/formWidgets/gender_drop_down.dart';
import '../../../../../global/widgets/formWidgets/intl_phone_field.dart';
import '../../../../../global/widgets/static/privacyPolicy/privacyPolicy.dart';
import '../../../../../packages/intlField/phone_number.dart';
import '../../bloc/register_bloc.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final SizeConfig _sizeConfig = locator<SizeConfig>();

  final UiHelper _uiHelper = locator<UiHelper>();

  final RegisterBloc _registerBloc = locator<RegisterBloc>();
  @override
  void initState() {
    _registerBloc.initStream();
    super.initState();
  }

  @override
  void dispose() {
    _registerBloc.closeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
        ),
        body: GestureDetector(
          onTap: () => _uiHelper.hideKeyboard(context),
          child: ListView(
            padding: EdgeInsets.all(0),
            physics: const BouncingScrollPhysics(),
            children: _uiHelper.listViewAnimator(
              children: [
                _uiHelper.mediumHeight,
                Padding(
                  padding: EdgeInsets.all(_sizeConfig.blockSizeW * 2),
                  child: Text("Register",
                      style: Theme.of(context).textTheme.headline5),
                ),
                _uiHelper.smallHeight,
                _fullNameField,
                _emailField,
                _passwordField,
                _uiHelper.smallHeight,
                _phoneNumberField,
                _dateOfBirthListTile(context),
                _uiHelper.smallHeight,
                //_uiHelper.smallHeight,
                GenderDropDown(bloc: _registerBloc),
                _uiHelper.smallHeight,
                _privacyPolicy,
                _uiHelper.largeHeight,
                _button(context),
                _uiHelper.largeHeight,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Align _button(context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AppButton(
        stream: _registerBloc.registerValid,
        title: ButtonStrings.register,
        act: () async {
          try {
            _uiHelper.hideKeyboard(context);
            _uiHelper.showLoader(context);

            final message = await _registerBloc.emailOrPhoneValidate();
            _uiHelper.showToast(msg: message);
            _registerBloc.registerPhoneOTP(
              context: context,
              verificationCompleted:
                  (PhoneAuthCredential phoneAuthCredential) async {
                final User? _user = (await _registerBloc
                        .firebase.firebaseAuthInstance
                        .signInWithCredential(phoneAuthCredential))
                    .user;
                if (_user != null) {
                  try {
                    _uiHelper.showToast(msg: UserAuthStrings.autoAuthOTP);
                    final val = await _registerBloc.register(_user.uid);
                    _uiHelper.showToast(msg: val, length: true);
                    Navigator.pop(context); //For poping the app loader
                    Navigator.pop(context);
                    Navigator.pushNamedAndRemoveUntil(
                        context, navigation, (route) => false);
                  } catch (e) {
                    if (e is NoSuchMethodError || e is TypeError) {
                      Exception("Sorry something went wrong.");
                      Navigator.pop(context);
                    }
                    _uiHelper.showToast(msg: e.toString(), length: true);
                    Navigator.pop(context);
                  }
                }
              },
              codeSent: (String verificationId, int? forceToken) async {
                Map<String, dynamic> _arguments = {
                  "verificationId": verificationId,
                  "forceToken": forceToken,
                  "isPhone":
                      true, //Because the registration will always be from phoneOTP, although default is true on pinverification screen
                  "fromRegister": true,
                  'phoneNo': _registerBloc.phoneValue,
                  'email': _registerBloc.emailValue,
                  'countryCode': _registerBloc.countryCodeValue,
                };

                final _uid = await Navigator.pushNamed(
                  context,
                  phonePinVerification,
                  arguments: _arguments,
                );
                try {
                  final message = await _registerBloc.register(_uid.toString());
                  _uiHelper.showToast(msg: message);
                  Navigator.pushNamedAndRemoveUntil(
                      context, splash, (route) => false);
                } catch (ex) {
                  _uiHelper.showToast(msg: ex.toString(), length: false);
                  Navigator.pop(context);
                }
                // Navigator.pushReplacementNamed(context, navigation);
              },
            );
          } catch (e) {
            _uiHelper.showToast(msg: e.toString(), length: false);
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  StreamBuilder get _privacyPolicy {
    return StreamBuilder<bool>(
        stream: _registerBloc.checkList,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return snapshot.hasData
              ? Padding(
                  padding: EdgeInsets.only(
                    left: _sizeConfig.blockSizeH * 2,
                    right: _sizeConfig.blockSizeH * 2,
                  ),
                  child: CheckboxListTile(
                    value: snapshot.data,
                    onChanged: (bool? value) {
                      _registerBloc.changeCheckList;
                    },
                    title: AppTextButton(
                      title: UserAuthStrings.privacyPolicy,
                      onTap: () => showModalBottomSheet(
                        isDismissible: true,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return PrivacyPolicy();
                        },
                      ),
                    ),
                  ),
                )
              : Container();
        });
  }

  AppTextField get _fullNameField {
    return AppTextField(
      stream: _registerBloc.fullName,
      onChangeParams: _registerBloc.changeFullName,
      labelText: UserAuthStrings.fullName,
      prefixIcon: Icon(Icons.person_outline),
    );
  }

  Widget _dateOfBirthListTile(context) {
    return DateTimeWidget(
      bloc: _registerBloc,
    );
  }

  AppTextField get _emailField {
    return AppTextField(
      labelText: UserAuthStrings.email,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icon(Icons.email_outlined),
      stream: _registerBloc.email,
      onChangeParams: _registerBloc.changeEmail,
    );
  }

  AppTextField get _passwordField {
    return AppTextField(
      labelText: UserAuthStrings.password,
      prefixIcon: Icon(Icons.lock_outline_rounded),
      stream: _registerBloc.password,
      onChangeParams: _registerBloc.changePassword,
      isPassword: true,
    );
  }

  AppIntlTextField get _phoneNumberField {
    return AppIntlTextField(
      prefixIcon: Icon(Icons.phone_android_rounded),
      labelText: UserAuthStrings.phoneNo,
      onChangeParams: (PhoneNumber phoneNumber) {
        _registerBloc.changeCountryCode(phoneNumber.countryCode);
        _registerBloc.changePhone(phoneNumber.number);
        _registerBloc.chnageCountryISOCode(phoneNumber.countryISOCode);
      },
      keyboardType: TextInputType.phone,
      stream: _registerBloc.phone,
    );
  }
}
