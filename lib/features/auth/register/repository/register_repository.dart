import '../../../../configurations/serviceLocator/locator.dart';
import '../../../../global/constants/strings/api/apiStrings.dart'
    show AuthUrls, LocalStorageKeys;
import '../../../../global/models/user/userModel.dart';

class RegisterRepository {
  final _localStorage = locator<LocalStorage>();
  final _api = locator<ApiRepository>();
  final _authUrls = AuthUrls();
  final _envModel = locator<EnvironmentModel>();
  final _envBloc = locator<EnvironmentBloc>();

  void saveData(
      token, username, name, email, phoneNo, verified, phoneVerified, code) {
    _envModel.tokenSet = token;
    _envModel.usernameSet = username;
    _envModel.nameSet = name;
    _envModel.emailSet = email;
    _envModel.phoneSet = phoneNo;
    _envModel.verifiedSet = verified;
    _envModel.phoneVerified = phoneVerified;
    _envModel.countryCodeSet = code;

    _localStorage.setLocalValue(
      key: LocalStorageKeys.token,
      value: token,
    );
    _localStorage.setLocalValue(
      key: LocalStorageKeys.username,
      value: username,
    );
    _localStorage.setLocalValue(
      key: LocalStorageKeys.name,
      value: name,
    );
    _localStorage.setLocalValue(
      key: LocalStorageKeys.email,
      value: email,
    );
    _localStorage.setLocalValue(
      key: LocalStorageKeys.phoneNo,
      value: phoneNo,
    );
    _localStorage.setLocalValue(
      key: LocalStorageKeys.verified,
      value: verified.toString(),
    );
    _localStorage.setLocalValue(
      key: LocalStorageKeys.phoneVerified,
      value: phoneVerified.toString(),
    );
    _localStorage.setLocalValue(
      key: LocalStorageKeys.code,
      value: code.toString(),
    );

    _envBloc.setValues();
  }

  register(Map<String, dynamic> body) async {
    try {
      final Response response = await _api.postRequest(
        url: _authUrls.register,
        body: body,
      );
      final UserModel _user = UserModel.fromJson(response.data);
      _envModel.tokenSet = _user.data!.token;
      saveData(
          _user.data!.token,
          _user.data!.username,
          _user.data!.name,
          _user.data!.email,
          _user.data!.phoneNumber,
          _user.data!.verified,
          _user.data!.phoneVerified,
          _user.data!.countryCode);
      return "Welcome ${_user.data!.name}. Shop with Us!!. Also, check your email for verification, don't forget to check your spam as well 😉.";
    } catch (e) {
      throw e;
    }
  }

  registerCheck(Map<String, dynamic> body) async {
    try {
      final Response response =
          await _api.postRequest(url: _authUrls.registerCheck, body: body);
      return (response.data);
    } catch (e) {
      throw e;
    }
  }

  otpLogin(Map<String, dynamic> body) async {
    try {
      final Response response = await _api.postRequest(
        url: _authUrls.loginOTP,
        body: body,
      );
      final UserModel _user = UserModel.fromJson(response.data);
      saveData(
          _user.data!.token,
          _user.data!.username,
          _user.data!.name,
          _user.data!.email,
          _user.data!.phoneNumber,
          _user.data!.verified,
          _user.data!.phoneVerified,
          _user.data!.countryCode);
      return "Welcome ${_user.data!.name}. Shop with Us!!";
    } catch (e) {
      throw e;
    }
  }
}
