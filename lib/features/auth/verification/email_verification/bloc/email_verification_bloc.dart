import 'package:rxdart/subjects.dart';

import '../../../../../configurations/repository/app_api_exception.dart';
import '../../../../../configurations/serviceLocator/locator.dart';
import '../../../../../global/constants/helpers/validators.dart';

class EmailPinVerificationBloc with AuthValidators {
  final ProfileRepository _profileRepository = locator<ProfileRepository>();
  //*Streams for PinVerification Module
  final BehaviorSubject<String> _pin = BehaviorSubject<String>();
  final BehaviorSubject<String> _email = BehaviorSubject<String>();
  //*Streams for PinVerification Module

  //*Getter for Streams
  Stream<String> get pin => _pin.stream.transform(validatePin);
  Stream<String> get email => _email.stream.transform(validateEmail);
  //*Getter for Streams

  //*Validation of buttons
  Stream<bool> get pinValid => pin.map((pin) => true);
  //*Validation of buttons

  //*Data modifiers/setters
  Function(String) get changePin => _pin.sink.add;
  Function(String) get changeEmail => _email.sink.add;
  //*Data modifiers/setters

  verifyEmail(String email) async {
    try {
      final Response _response = await _profileRepository.verifyEmail(
        email: email,
        pin: _pin.valueOrNull,
      );
      return _response.data['message'];
    } on AppApiException catch (e) {
      throw e.message ?? 'Server error';
    } catch (e) {
      throw e.toString();
    }
  }

  closeStream() {
    _pin.close();
    _email.close();
  }
}
