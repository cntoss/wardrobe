import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/subjects.dart';

import '../../../../../configurations/firebase/firebase_config.dart';
import '../../../../../configurations/serviceLocator/locator.dart';
import '../../../../../global/constants/helpers/validators.dart';

class PhonePinVerificationBloc with AuthValidators {
  final FirebaseAuth _firebaseAuth =
      locator<FirebaseConfig>().firebaseAuthInstance;
  //*Streams for PinVerification Module
  final BehaviorSubject<String> _pin = BehaviorSubject<String>();
  final BehaviorSubject<String> _uid = BehaviorSubject<String>();
  final BehaviorSubject<bool> _valid = BehaviorSubject<bool>.seeded(false);
  //*Streams for PinVerification Module

  //*Value accessors
  bool get validValue => _valid.value;
  //*Value accessors

  //*Getter for Streams
  Stream<String> get pin => _pin.stream.transform(validatePin);
  Stream<String> get uid => _uid.stream;
  Stream<bool> get valid => _valid.stream;
  //*Getter for Streams

  //*Validation of buttons
  Stream<bool> get pinValid => pin.map((pin) => true);
  //*Validation of buttons

  //*Data modifiers/setters
  Function(String) get changePin => _pin.sink.add;
  //*Data modifiers/setters

  //*Firebase authentication from phone
  Future<String?> loginByCredential({required String verificationId}) async {
    try {
      AuthCredential _credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: _pin.value);
      final _userCredentials =
          await _firebaseAuth.signInWithCredential(_credential);
      User? _user = _userCredentials.user;
      if (_user != null) {
        _uid.sink.add(_user.uid);
        _valid.sink.add(true);
        return _user.uid;
      } else {
        _valid.sink.add(false);
      }
    } catch (e) {
      throw e;
    }
  }

  clearValue() {
    _pin.sink.add('');//pin.sink.add(null);
    _uid.sink.add('');
    _valid.sink.add(false);
  }

  closeStream() {
    _pin.close();
    _uid.close();
    _valid.close();
  }
}
