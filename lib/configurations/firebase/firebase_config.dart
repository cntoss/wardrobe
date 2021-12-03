import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../serviceLocator/locator.dart';

export 'package:firebase_auth/firebase_auth.dart';

class FirebaseConfig {
  final UiHelper _uiHelper = locator<UiHelper>();

  final FirebaseAuth _firebaseAuthInstance = FirebaseAuth.instance;
  FirebaseAuth get firebaseAuthInstance => _firebaseAuthInstance;

  phoneOTP({
    required BuildContext context,
    required String phoneNo,
    required Function(String, int?) codeSent,
    required Function(PhoneAuthCredential phoneAuthCredential)
        verificationCompleted,
  }) {
    _firebaseAuthInstance.verifyPhoneNumber(
      timeout: Duration(seconds: 30),
      phoneNumber: phoneNo,
      verificationCompleted: verificationCompleted,
      verificationFailed: (FirebaseAuthException e) {
        Navigator.pop(context);//to hide loader
        _uiHelper.showToast(msg: e.message ?? 'Phone number doesnot verify');
      },
      codeSent: codeSent,
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
