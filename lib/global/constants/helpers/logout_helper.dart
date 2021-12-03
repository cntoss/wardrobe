import 'package:wardrobe/configurations/router/route_config.dart';
import 'package:wardrobe/configurations/router/router.dart';
import 'package:wardrobe/configurations/serviceLocator/locator.dart';
import 'package:flutter/material.dart';

class LogoutHelper {
  logout() async {
    final LocalStorage _localStorage = locator<LocalStorage>();
    final EnvironmentModel _environmentModel = locator<EnvironmentModel>();

    await _localStorage.deleteAllLocalValue();

    _environmentModel.tokenSet = null;
    _environmentModel.usernameSet = null;
    Navigator.pushNamedAndRemoveUntil(
      RouteConfig.navigatorKey.currentState!.context,
      splash,
      (route) => false,
    );
  }

  loginError() {
    Navigator.pushNamedAndRemoveUntil(
      RouteConfig.navigatorKey.currentState!.context,
      splash,
      (route) => false,
    );
  }
}
