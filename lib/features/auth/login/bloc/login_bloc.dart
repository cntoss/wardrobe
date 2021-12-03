import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:rxdart/rxdart.dart' show BehaviorSubject, Rx;

import '../../../../configurations/repository/app_api_exception.dart';
import '../../../../configurations/serviceLocator/locator.dart';
import '../../../../global/constants/helpers/validators.dart'
    show AuthValidators;
import '../../../../global/constants/strings/api/apiParams.dart'
    show AuthKeyData;
import '../../../../global/models/user/authCheckModel.dart';
import '../model/login_model.dart';

class LoginBloc with AuthValidators {
  final FirebaseConfig _firebaseAuth = locator<FirebaseConfig>();
  final _appEnv = locator<EnvironmentModel>();
  final _loginApi = locator<
      LoginRepository>(); //* Carries out all the API functions for Login module
  //*StreamControllers for Login Module
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _phoneNo = BehaviorSubject<String>();
  final _countryCode = BehaviorSubject<String>();
  final _changeField = BehaviorSubject<bool>.seeded(true);
  final _loginBy = BehaviorSubject<bool>.seeded(true);
  final _next = BehaviorSubject<bool>.seeded(false);
  //*StreamControllers for Login Module

  //*Getter for Streams
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<String> get phoneNo => _phoneNo.stream.transform(validatePhoneNo);
  Stream<String> get countryCode => _countryCode.stream;
  Stream<bool> get changeField => _changeField.stream;
  Stream<bool> get loginBy => _loginBy.stream;
  Stream<bool> get next => _next.stream;
  //*Getter for Streams

  //*Value accessors
  String get emailValue => _email.value;
  FirebaseConfig get firebase => _firebaseAuth;
  String get phoneValue => _phoneNo.value;
  String get countryCodeValue => _countryCode.value;
  bool get fieldValue => _changeField.value;
  bool get nextValue => _next.value;
  //*Value accessors

  //*Rx combining for validation of buttons
  Stream<bool> get loginValid => Rx.combineLatest2(
      email, password, (e, p) => true); //Validates the login button
  Stream<bool> get emailValid => email.map((email) =>
      true); //Determines if the button should be enabled as per data entered by the user
  Stream<bool> get phoneValid => phoneNo.map((phone) =>
      true); //Determines if the button should be enabled as per data entered by the user
  //*Rx combining for validation of buttons

  //*Data modifiers/setters
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changePhone => _phoneNo.sink.add;
  Function(String) get changeCountryCode => _countryCode.sink.add;

  void get changeLoginBy {
    _loginBy.sink.add(!_loginBy.value);
  }

  void get changeFieldValue => _changeField.sink.add(!_changeField.value);
  void get changeNext => _next.sink.add(!_next.value);
  void get setNextToFalse => _next.sink.add(false);
  //*Data modifiers/setters

  //*Validation Checking for if the email or phone no already exists or not.

  emailOrPhoneValidate() async {
    LoginModel _model;

    if (_loginBy.value) {
      _model = LoginModel(
        email: _email.valueOrNull,
      );
    } else {
      _model = LoginModel(
        countryCode: _countryCode.valueOrNull,
        phoneNumber: _phoneNo.valueOrNull,
      );
    }

    try {
      final _response = await _loginApi.loginCheck(_model.toJson());
      final AuthCheckModel _loginCheck = AuthCheckModel.fromJson(_response);
      return _loginCheck.message;
    } on AppApiException catch (e) {
      throw e.message ?? 'Server error';
    } catch (e) {
      throw e.toString();
    }
  }

  //* Login to the server and fetch the auth token.
  login() async {
    LoginModel _model;

    if (_appEnv.oneSignalPlayerId == null) {
      var status = await OneSignal.shared.getDeviceState();
      String? playerId = status!.userId;
      _appEnv.oneSignalPlayerId = playerId;
    }

    if (_loginBy.value) {
      _model = LoginModel(
          email: _email.valueOrNull,
          password: _password.valueOrNull,
          source: _appEnv.platform,
          oneSignalPlayerId: _appEnv.oneSignalPlayerId);
    } else {
      _model = LoginModel(
          phoneNumber: _phoneNo.valueOrNull,
          countryCode: _countryCode.valueOrNull,
          password: _password.valueOrNull,
          source: _appEnv.platform,
          oneSignalPlayerId: _appEnv.oneSignalPlayerId);
    }
    try {
     /*  if (_appEnv.environment == 'development') {
        var status = await OneSignal.shared.getDeviceState();
        if (!status!.subscribed) {
          throw Exception('Notification Unsubscribe');
        } else if (status.userId == null) {
          throw Exception('Signal ID null');
        }
      } */

      final _response = await _loginApi.login(_model.toJson());
      clear();
      return (_response);
    } on AppApiException catch (e) {
      throw e.message ?? 'Server error';
    } catch (e) {
      throw e.toString();
    }
  }

  loginPhoneOTP({
    required context,
    required Function(String, int?) codeSent,
    Function(String)? codeAutoRetrieval,
    required Function(PhoneAuthCredential phoneAuthCredential)
        verificationCompleted,
  }) {
    _firebaseAuth.phoneOTP(
      context: context,
      verificationCompleted: verificationCompleted,
      phoneNo: _countryCode.valueOrNull ??
          '' + '${_phoneNo.hasValue ? _phoneNo.value : ''}',
      codeSent: codeSent,
    );
  }

  otpLogin(String uid) async {
    if (_appEnv.oneSignalPlayerId == null) {
      var status = await OneSignal.shared.getDeviceState();
      String? playerId = status!.userId;
      _appEnv.oneSignalPlayerId = playerId;
    }
    final String _phoneNoValue = _phoneNo.value;
    final String _countryCodeValue = _countryCode.value;
    final Map<String, dynamic> _loginParams = {
      AuthKeyData.phoneNumber: _phoneNoValue,
      AuthKeyData.countryCode: _countryCodeValue.replaceAll("+", ""),
      AuthKeyData.source: _appEnv.platform,
      AuthKeyData.uid: uid,
      AuthKeyData.oneSignalPlayerId: _appEnv.oneSignalPlayerId,
    };
    try {
      final _response = await _loginApi.otpLogin(_loginParams);
      clear();
      return (_response);
    } on AppApiException catch (e) {
      throw e.message ?? 'Server error';
    } catch (e) {
      throw e.toString();
    }
  }

  facebookLogin() async {
    try {
      final _response = await _loginApi.facebookLogin();
      clear();
      return _response;
    } on AppApiException catch (e) {
      throw e.message ?? 'Server error';
    } catch (e) {
      throw e.toString();
    }
  }

  googleLogin() async {
    try {
      final _response = await _loginApi.googleLogin();
      clear();
      return (_response);
    } on AppApiException catch (e) {
      throw e.message ?? 'Server error';
    } on PlatformException catch (_) {
      throw "Your device did not login with google service";
    } catch (e) {
      throw e.toString();
    }
  }

  appleLogin() async {
    try {
      final _response = await _loginApi.appleLogin();
      clear();
      return (_response);
    } on AppApiException catch (e) {
      throw e.message ?? 'Server error';
    } on PlatformException catch (_) {
      throw "Your device did not login with apple service";
    } catch (e) {
      throw e.toString();
    }
  }

  clear() {
    _password.sink.add("");
  }

  closeStream() {
    _email.close();
    _loginBy.close();
    _phoneNo.close();
    _countryCode.close();
    _password.close();
    _changeField.close();
    _next.close();
  }
}
