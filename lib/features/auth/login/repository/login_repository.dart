import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart' show Response;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../configurations/serviceLocator/locator.dart';
import '../../../../global/constants/strings/api/apiStrings.dart'
    show AuthUrls, LocalStorageKeys;
import '../../../../global/models/user/userModel.dart';
import '../../../../main/model/environment_model.dart';
import '../model/social_model.dart';

class LoginRepository {
  final _localStorage = locator<LocalStorage>();
  final _firebase = locator<FirebaseConfig>().firebaseAuthInstance;
  final _api = locator<ApiRepository>();
  final _envModel = locator<EnvironmentModel>();
  final _envBloc = locator<EnvironmentBloc>();
  final _authUrls = AuthUrls();
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
    if (phoneNo != null) {
      _localStorage.setLocalValue(
        key: LocalStorageKeys.phoneNo,
        value: phoneNo,
      );
    }
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
    _localStorage.setLocalValue(
      key: LocalStorageKeys.isLogin,
      value: 'True',
    );
    _envBloc.setValues();
  }

  login(Map<String, dynamic> body) async {
    try {
      final Response response = await _api.postRequest(
        url: _authUrls.login,
        body: body,
      );
      final UserModel _user = UserModel.fromJson(response.data);
      _envModel.tokenSet = _user.data!.token!;
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

  loginCheck(Map<String, dynamic> body) async {
    try {
      final Response response =
          await _api.postRequest(url: _authUrls.loginCheck, body: body);
      return (response.data);
    } catch (e) {
      throw e;
    }
  }

  facebookLogin() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (_envModel.oneSignalPlayerId == null) {
        var status = await OneSignal.shared.getDeviceState();
        String? playerId = status!.userId;
        _envModel.oneSignalPlayerId = playerId;
      }

      if (loginResult.accessToken != null) {
        final AccessToken? result = loginResult.accessToken;
        // final result = await facebookLogin.logIn(['email', 'public_profile']);
        // final token = result.accessToken.token;
        final Response graphResponse = await Dio().get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${result!.token}');
        Map<String, dynamic> responseData = jsonDecode(graphResponse.data);
        final SocialPostModel _facebookModel = SocialPostModel(
            oneSignalPlayerId: _envModel.oneSignalPlayerId,
            inputToken: result.token,
            profile: Profile(
              id: responseData['id'],
              name: responseData['name'],
              email: responseData['email'],
            ),
            source: _envModel.platform);
        final Response response = await _api.postRequest(
          url: _authUrls.facebookLogin,
          body: _facebookModel.toJson(),
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
      } else
        throw Exception("Facebook Login Cancelled Successfully.");
    } catch (e) {
      if (e is NoSuchMethodError) {
        throw Exception("Facebook Login Cancelled Successfully.");
      } else {
        throw e;
      }
    }
  }

  googleLogin() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential signInWithCredentials =
          await _firebase.signInWithCredential(credential);
      final User _userFromGoogleSignIn = signInWithCredentials.user!;

      _googleSignIn.disconnect();
      // return _user;

      if (_envModel.oneSignalPlayerId == null) {
        var status = await OneSignal.shared.getDeviceState();
        String? playerId = status!.userId;
        _envModel.oneSignalPlayerId = playerId;
      }

      final SocialPostModel _googleModel = SocialPostModel(
          oneSignalPlayerId: _envModel.oneSignalPlayerId,
          inputToken: googleAuth.idToken,
          profile: Profile(
              email: _userFromGoogleSignIn.email,
              id: _userFromGoogleSignIn.uid,
              name: _userFromGoogleSignIn.displayName,
              picture: _userFromGoogleSignIn.photoURL),
          source: _envModel.platform);

      final Response response = await _api.postRequest(
        url: _authUrls.googleLogin,
        body: _googleModel.toJson(),
      );
      final UserModel _user = UserModel.fromJson(response.data);
      _envModel.tokenSet = _user.data!.token!;
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
      if (e is NoSuchMethodError) {
        throw Exception("Google Login Cancelled Successfully.");
      } else {
        throw e;
      }
    }
  }

  String generateNonce([int length = 32]) {
    const charset =
        '98476932845ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyzwardrobe';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  appleLogin() async {
    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);
      bool result = await SignInWithApple.isAvailable();
      debugPrint(result.toString());
      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
            clientId:
                '125981109154-vkmebtmh8c2e0m02iemkc0rvpbt9aih5.apps.googleusercontent.com',
            redirectUri: Uri.parse(
                'https://wardrobe-d747e.firebaseapp.com/__/auth/handler')),
        nonce: nonce,
      );
      debugPrint(appleCredential.email);
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );
      final UserCredential signInWithCredentials =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      final User _userFromAppleSignIn = signInWithCredentials.user!;

      // return _user;

      if (_envModel.oneSignalPlayerId == null) {
        var status = await OneSignal.shared.getDeviceState();
        String? playerId = status!.userId;
        _envModel.oneSignalPlayerId = playerId;
      }

      final SocialPostModel _appleModel = SocialPostModel(
          oneSignalPlayerId: _envModel.oneSignalPlayerId,
          inputToken: appleCredential.identityToken,
          profile: Profile(
              email: _userFromAppleSignIn.email,
              id: _userFromAppleSignIn.uid,
              name: _userFromAppleSignIn.displayName,
              picture: _userFromAppleSignIn.photoURL),
          source: _envModel.platform);

      final Response response = await _api.postRequest(
        url: _authUrls.googleLogin, //appleLogin
        body: _appleModel.toJson(),
      );
      final UserModel _user = UserModel.fromJson(response.data);
      _envModel.tokenSet = _user.data!.token!;
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
      if (e is NoSuchMethodError) {
        throw Exception("Apple Login Cancelled Successfully.");
      } else {
        throw e;
      }
    }
  }

  otpLogin(Map<String, dynamic> body) async {
    try {
      final Response response = await _api.postRequest(
        url: _authUrls.loginOTP,
        body: body,
      );
      final UserModel _user = UserModel.fromJson(response.data);
      _envModel.tokenSet = _user.data!.token!;
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
