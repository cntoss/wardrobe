import 'dart:async';

import 'package:wardrobe/configurations/serviceLocator/locator.dart';
import 'package:flutter/services.dart';
import 'package:phone_number/phone_number.dart';

import '../strings/appStrings/appStrings.dart';

class AuthValidators {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email) &&
        //email != null &&
        email != "") {
      sink.add(email);
    } else {
      sink.addError(UserAuthStrings.validateEmail);
    }
  });

  final validateUsername = StreamTransformer<String, String>.fromHandlers(
    handleData: (username, sink) {
      if (username.contains('/')) {
        sink.addError("Please enter your username only.");
      } else {
        sink.add(username);
      }
    },
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    sink.add(password);

    /* if (password.length > 5) {
      sink.add(password);
    } else {
      sink.addError(UserAuthStrings.validatePassword);
    } */
  });

  final validatePin =
      StreamTransformer<String, String>.fromHandlers(handleData: (pin, sink) {
    if (pin.length == 6 && int.tryParse(pin) != null) {
      sink.add(pin);
    } else {
      sink.addError(UserAuthStrings.validatePin);
    }
  });

  final validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 4) {
      sink.add(name);
    } else {
      sink.addError(UserAuthStrings.validateName);
    }
  });

  final validateDateOfBirth =
      StreamTransformer<DateTime, DateTime>.fromHandlers(
          handleData: (dob, sink) {
    if (dob.isBefore(DateTime.now().add(Duration(days: 1)))) {
      sink.add(dob);
    } else {
      sink.addError(UserAuthStrings.validateDob);
    }
  });

  final validatePhoneNo = StreamTransformer<String, String>.fromHandlers(
      handleData: (phoneNo, sink) async {
    if (RegExp(r'^(?:[+0][1-9])?[0-9]{5,17}$').hasMatch(phoneNo)) {
      ParseResult? result = await parse(phoneNo,
          countryCode: locator<RegisterBloc>().countryISOCodeValue);
      if (result.hasError) {
        sink.addError(result.errorCode ?? UserAuthStrings.validatePhone);
      } else {
        sink.add(phoneNo);
      }
    } else {
      sink.addError(UserAuthStrings.validatePhone);
    }
  });
}

Future<ParseResult> parse(String string, {String? countryCode}) async {
  //debugPrint("parse $string for region: $countryCode");
  try {
    final PhoneNumberUtil plugin = PhoneNumberUtil();

    final result = await plugin.parse(string, regionCode: countryCode);
    return ParseResult(result);
  } on PlatformException catch (e) {
    return ParseResult.error(e.code);
  }
}

class ParseResult {
  final PhoneNumber? phoneNumber;
  final String? errorCode;

  ParseResult._({
    this.phoneNumber,
    this.errorCode,
  });

  bool get hasError => errorCode != null;

  factory ParseResult(PhoneNumber phoneNumber) => ParseResult._(
        phoneNumber: phoneNumber,
      );

  factory ParseResult.error(code) => ParseResult._(errorCode: code);

  @override
  String toString() {
    return 'ParseResult{'
        'e164: ${phoneNumber?.e164}, '
        'type: ${phoneNumber?.type}, '
        'international: ${phoneNumber?.international}, '
        'national: ${phoneNumber?.national}, '
        'countryCode: ${phoneNumber?.countryCode}, '
        'nationalNumber: ${phoneNumber?.nationalNumber}, '
        'errorCode: $errorCode}';
  }
}
