import 'package:rxdart/subjects.dart';
import 'package:wardrobe/features/auth/forgot_password/repository/forgot_password_repository.dart';

import '../../../../configurations/repository/app_api_exception.dart';
import '../../../../global/constants/helpers/validators.dart';
import '../../../../global/models/user/authCheckModel.dart';

class ForgotPasswordBloc with AuthValidators {
  final ForgotPasswordRepository _repository =
      ForgotPasswordRepository();
  final BehaviorSubject<String> _email = BehaviorSubject<String>();
  //*Streams for ForgotPassword Module
  Stream<String> get email => _email.stream.transform(validateEmail);
  //*Streams for ForgotPassword Module

  //*Rx combining for validating button
  Stream<bool> get emailValid => email.map((email) => true);

  //*Data modifiers/setters
  Function(String) get changeEmail => _email.sink.add;
  //*Data modifiers/setters

  forgotPassword() async {
    Map<String, dynamic> _body = {
      'email': _email.valueOrNull,
    };
    try {
      final _response = await _repository.forgotPassword(_body);
      final AuthCheckModel _check = AuthCheckModel.fromJson(_response.data);
      return _check.message;
    } on AppApiException catch (e) {
      throw e.message ?? "Server Error";
    } catch (e) {
      throw e.toString();
    }
  }

  closeStream() async {
    _email.close();
    await _email.drain();
  }
}
