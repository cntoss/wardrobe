import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../configurations/serviceLocator/locator.dart';
import '../../configurations/theme/app_colors.dart';
import '../init/main.dart';
import 'app_configuration.dart';

Future<void> mainBase(AppEnvironment appEnvironment) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: AppColors.appPrimary),
  );

  await AppConfiguration.initialize(appEnvironment);

  setLocator();
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  if (Platform.isIOS) {
    OneSignal.shared.setRequiresUserPrivacyConsent(true);
    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      debugPrint("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
    });
  }
  await OneSignal.shared.setAppId(locator<EnvironmentModel>().oneSignalAppId);
  if (locator<EnvironmentModel>().oneSignalPlayerId == null) {
    var status = await OneSignal.shared.getDeviceState();
    String? playerId = status!.userId;
    locator<EnvironmentModel>().oneSignalPlayerId = playerId;
    locator<EnvironmentBloc>().setValues();
    if (!status.subscribed && Platform.isIOS) {
      OneSignal.shared.addTrigger("prompt_ios", 'true');
    }
  }

  runApp(
   const MainApp(),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({
    Key? key,
  }) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: Colors.black,
      builder: (context, child) => const Wardrobe(),
      debugShowCheckedModeBanner: false,
    );
  }
}
