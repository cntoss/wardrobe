import 'package:wardrobe/global/constants/strings/api/apiStrings.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../configurations/serviceLocator/locator.dart';
import '../../../../configurations/repository/app_api_exception.dart';

import '../../../constants/helpers/validators.dart';
import '../model/contactModel.dart';
import '../repository/staticDataRepository.dart';

class StaticDataBloc with AuthValidators {
  final StaticDataRepository _staticDataRepository =
      locator<StaticDataRepository>();
  final _localStorage = locator<LocalStorage>();

  BehaviorSubject<PolicyModel> _privacyPolicy = BehaviorSubject<PolicyModel>();
  BehaviorSubject<PolicyModel> _refundPolicy = BehaviorSubject<PolicyModel>();
  BehaviorSubject<ContactModel> _contactUs = BehaviorSubject<ContactModel>();
  final _email = BehaviorSubject<String>();
  final _phoneNo = BehaviorSubject<String>();
  final _fullName = BehaviorSubject<String>();
  final _message = BehaviorSubject<String>();
  final _fetchLocal = BehaviorSubject<bool>();

  //*Stream getters
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get fullName => _fullName.stream;
  Stream<String> get message => _message.stream;
  Stream<String> get phoneNo => _phoneNo.stream.transform(validatePhoneNo);
  Stream<PolicyModel> get privacyPolicy => _privacyPolicy.stream;
  Stream<PolicyModel> get refundPolicy => _refundPolicy.stream;
  Stream<ContactModel> get contactUs => _contactUs.stream;
  Stream<bool> get fetchedLocal => _fetchLocal.stream;

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePhoneNo => _phoneNo.sink.add;
  Function(String) get changeFullName => _fullName.sink.add;
  Function(String) get changeMessage => _message.sink.add;

  String? get localName => _fullName.valueOrNull;
  String? get localEmail => _email.valueOrNull;
  String? get localPhone => _phoneNo.valueOrNull;

  Stream<bool> get submitValid => Rx.combineLatest4(
      email, fullName, message, phoneNo, (e, fn, m, pn) => true);

  //changed e.message to e.toString() v2
  fetchPrivacyPolicy() async {
    try {
      final PolicyModel response = await _staticDataRepository.privacyPolicy();
      _privacyPolicy.sink.add(response);
    } on AppApiException catch (e) {
      throw e.message ?? 'Server error';
    } catch (e) {
      throw e.toString();
    }
  }

  fetchRefundPolicy() async {
    try {
      final PolicyModel response = await _staticDataRepository.refundPolicy();
      _refundPolicy.sink.add(response);
    } on AppApiException catch (e) {
      throw e.message ?? 'Server error';
    } catch (e) {
      throw e.toString();
    }

    /*  await _staticDataRepository.refundPolicy().then((response) => 
      _refundPolicy.sink.add(response)).catchError(onError  = > throw(onError.))); */
  }

  fetchContactUs() async {
    try {
      final ContactModel response = await _staticDataRepository.contactUs();
      _contactUs.sink.add(response);
    } on AppApiException catch (e) {
      throw e.message ?? 'Server error';
    } catch (e) {
      throw e.toString();
    }
  }

  fetchUserData() async {
    String? _localEmail =
        await _localStorage.getLocalValue(key: LocalStorageKeys.email);
    String? _localPhone =
        await _localStorage.getLocalValue(key: LocalStorageKeys.phoneNo);
    String? _localName =
        await _localStorage.getLocalValue(key: LocalStorageKeys.name);

    if (_localEmail != null) {
      _email.sink.add(_localEmail);
    }

    if (_localPhone != null) {
      _phoneNo.sink.add(_localPhone);
    }

    if (_localName != null) {
      _fullName.sink.add(_localName);
    }

    _fetchLocal.sink.add(true);
  }

  submitForm() async {
    try {
      final response = await _staticDataRepository.contactUsForm({
        "name": _fullName.valueOrNull,
        "email": _email.valueOrNull,
        "phonenumber": _phoneNo.valueOrNull,
        "message": _message.valueOrNull,
      });
      return (response.data["message"]);
    } on AppApiException catch (e) {
      throw e.message ?? 'Server error';
    } catch (e) {
      throw e.toString();
    }
  }

  closeStream() {
    _privacyPolicy.close();
    _refundPolicy.close();
    _contactUs.close();
    _message.close();
    _email.close();
    _fullName.close();
    _phoneNo.close();
    _fetchLocal.close();
  }
}
