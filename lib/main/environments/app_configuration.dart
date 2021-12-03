import 'dart:convert';
import 'dart:io' show Platform;

import 'package:wardrobe/configurations/repository/ip_request.dart';
import 'package:wardrobe/global/constants/strings/api/apiStrings.dart';
import 'package:wardrobe/main/model/environment_model.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

import '../../configurations/serviceLocator/locator.dart';

//TODO:Create and add dart-define to define the environment variables.
//TODO:Create and add android flavor or iOS schemas for the app to run different application for development and production build.
//*For Reading the configuration file.
class AppConfiguration {
  static late Map<String, dynamic> _configJson;

  static Future<void> initialize(AppEnvironment appEnvironment) async {
    String os = Platform.operatingSystem; //in your code
    PackageInfo _packageInfo = await PackageInfo.fromPlatform();
    String? _ip = await IpRequest().getIp();
    final configString =
        await rootBundle.loadString('assets/envConfig/appConfig.json');
    _configJson = json.decode(configString) as Map<String, dynamic>;
    locator.registerLazySingleton(
      () => LocalStorage(),
    );

    final token = await locator<LocalStorage>()
        .getLocalValue(key: LocalStorageKeys.token);
    final username = await locator<LocalStorage>()
        .getLocalValue(key: LocalStorageKeys.username);
    final name =
        await locator<LocalStorage>().getLocalValue(key: LocalStorageKeys.name);
    final email = await locator<LocalStorage>()
        .getLocalValue(key: LocalStorageKeys.email);
    final phoneNo = await locator<LocalStorage>()
        .getLocalValue(key: LocalStorageKeys.phoneNo);
    final verified = await locator<LocalStorage>()
        .getLocalValue(key: LocalStorageKeys.verified);
    final phoneVerified = await locator<LocalStorage>()
        .getLocalValue(key: LocalStorageKeys.phoneVerified);
    final countryCode =
        await locator<LocalStorage>().getLocalValue(key: LocalStorageKeys.code);

    //Registering the EnvironmentModel to the App.
    locator.registerLazySingleton(
      () => EnvironmentModel(
          platform: os,
          environment: _configJson[appEnvironment.toString()]['environment'],
          mapAPIKey: _configJson[appEnvironment.toString()]['mapAPIKey'],
          baatoAPIKey: _configJson[appEnvironment.toString()]['baatoAPIKey'],
          appTitle: _configJson[appEnvironment.toString()]['appTitle'],
          apiUrl: _configJson[appEnvironment.toString()]['apiUrl'],
          baseUrl: _configJson[appEnvironment.toString()]['baseUrl'],
          oneSignalAppId: _configJson[appEnvironment.toString()]
              ['oneSignalAppId'],
          appBuildNumber: _packageInfo.buildNumber,
          appVersion: _packageInfo.version,
          token: token,
          username: username,
          name: name,
          email: email,
          phoneNo: phoneNo,
          countryCode: countryCode,
          phoneVerified: phoneVerified == null
              ? null
              : phoneVerified.toLowerCase() == "true",
          verified: verified == null ? null : verified.toLowerCase() == "true",
          ip: _ip),
    );
  }
}
