import 'package:rxdart/rxdart.dart' show BehaviorSubject, Rx;

import '../../../../configurations/repository/app_api_exception.dart';
import '../../../../configurations/serviceLocator/locator.dart';
import '../../../../global/constants/helpers/validators.dart';
import '../../../../global/models/user/authCheckModel.dart';
import '../model/register_model.dart';
import '../repository/register_repository.dart';

class RegisterBloc with AuthValidators {
  final FirebaseConfig _firebaseAuth = locator<FirebaseConfig>();
  final _appEnv = locator<EnvironmentModel>();
  final RegisterRepository _registerRepository = locator<RegisterRepository>();

  //*StreamControllers for Register Module
  late BehaviorSubject<String> _dropDown;
  late BehaviorSubject<DateTime> _dateTime;
  late BehaviorSubject<bool> _checkList;
  late BehaviorSubject<String> _fullName;
  late BehaviorSubject<String> _email;
  late BehaviorSubject<String> _password;
  late BehaviorSubject<String> _phoneNo;
  late BehaviorSubject<String> _countryCode;
  //countryIso code is used for phone number validation
  BehaviorSubject<String> _countryISOCode = BehaviorSubject<String>();
  //*StreamControllers for Register Module

  initISO() {
    _countryISOCode = BehaviorSubject<String>();
  }

  initStream() {
    _dropDown = BehaviorSubject<String>.seeded('Male');
    _dateTime = BehaviorSubject<DateTime>.seeded(DateTime.now());
    _checkList = BehaviorSubject<bool>.seeded(false);
    _fullName = BehaviorSubject<String>();
    _email = BehaviorSubject<String>();
    _password = BehaviorSubject<String>();
    _phoneNo = BehaviorSubject<String>();
    _countryCode = BehaviorSubject<String>();
    _countryISOCode = BehaviorSubject<String>();
  }

  //*Getter for Streams
  Stream<String> get dropDown => _dropDown.stream;
  Stream<DateTime> get dateTime =>
      _dateTime.stream.transform(validateDateOfBirth);
  Stream<bool> get checkList => _checkList.stream;
  FirebaseConfig get firebase => _firebaseAuth;
  Stream<String> get fullName => _fullName.stream.transform(validateName);
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<String> get phone => _phoneNo.stream.transform(validatePhoneNo);
  Stream<String> get countryCode => _countryCode.stream;
  //*Getter for Streams

  //*Value accessors
  String get emailValue => _email.value;
  String get phoneValue => _phoneNo.value;
  String get countryCodeValue => _countryCode.value;
  String get countryISOCodeValue => _countryISOCode.value;
  //*Value accessors

  //*Rx combining for validation of buttons
  Stream<bool> get registerValid => Rx.combineLatest7(
          fullName, email, password, phone, dateTime, dropDown, checkList,
          (f, e, p, pn, date, dropDown, c) {
        if (date != DateTime.now() && c != false) return true;
        return false;
      }); //Validates the register button

  //*Data modifiers/setters
  void get changeCheckList => _checkList.sink.add(!_checkList.value);
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changeFullName => _fullName.sink.add;
  Function(String) get changeCountryCode => _countryCode.sink.add;
  Function(String) get chnageCountryISOCode => _countryISOCode.sink.add;
  Function(String) get changePhone => _phoneNo.sink.add;
  Function(String) get changePassword => _password.sink.add;
  void changeDate(DateTime value) => _dateTime.sink.add(value);
  void changeDropDown(String? value) {
    if (value != null) _dropDown.sink.add(value);
  }
  //*Data modifiers/setters

  emailOrPhoneValidate() async {
    // Map<String, dynamic> _emailOrPhoneValidate;
    RegisterPostModel _registerModel;
    _registerModel = RegisterPostModel(
      email: _email.valueOrNull,
      oneSignalPlayerId: _appEnv.oneSignalPlayerId,
      countryCode: _countryCode.valueOrNull,
      phoneNumber: _phoneNo.valueOrNull,
    );

    try {
      final _response =
          await _registerRepository.registerCheck(_registerModel.toJson());
      final AuthCheckModel _loginCheck = AuthCheckModel.fromJson(_response);
      return _loginCheck.message;
    } on AppApiException catch (e) {
      throw e.message ?? 'Server error';
    } catch (e) {
      throw e.toString();
    }
  }

  registerPhoneOTP(
      {required context,
      required Function(PhoneAuthCredential) verificationCompleted,
      required Function(String, int?) codeSent,
      Function(String)? codeAutoRetrieval}) {
    // emptyCheckers();
    _firebaseAuth.phoneOTP(
      context: context,
      verificationCompleted: verificationCompleted,
      phoneNo:
          '${_countryCode.valueOrNull ?? ''}' + '${_phoneNo.valueOrNull ?? ''}',
      codeSent: codeSent,
    );
  }

  register(String uid) async {
    try {
      RegisterPostModel _registerModel;
      _registerModel = RegisterPostModel(
        email: _email.valueOrNull,
        countryCode: _countryCode.valueOrNull,
        phoneNumber: _phoneNo.valueOrNull,
        dob: _dateTime.valueOrNull,
        name: _fullName.valueOrNull,
        password: _password.valueOrNull,
        source: _appEnv.platform,
        uid: uid,
        oneSignalPlayerId: _appEnv.oneSignalPlayerId,
      );
      final _response =
          await _registerRepository.register(_registerModel.toJson());
      // final AuthCheckModel _registerCheck = AuthCheckModel.fromJson(_response);
      return _response;
    } on AppApiException catch (e) {
      throw e.message ?? 'Server error';
    } catch (e) {
      throw e.toString();
    }
  }

  closeISO() {
    _countryISOCode.close();
  }

  closeStream() async {
    _dropDown.close();
    _dateTime.close();
    _checkList.close();
    _email.close();
    _phoneNo.close();
    _password.close();
    _fullName.close();
    _countryCode.close();
    _countryISOCode.close();
  }
}
