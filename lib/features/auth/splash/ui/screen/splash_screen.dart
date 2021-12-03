import 'package:wardrobe/global/constants/images/logo.dart';
import 'package:wardrobe/global/widgets/formWidgets/app_button.dart';
import 'package:wardrobe/global/widgets/formWidgets/app_text_field.dart';
import 'package:flutter/material.dart';
//app review
//import 'package:launch_review/launch_review.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../../../configurations/router/router.dart';
import '../../../../../configurations/serviceLocator/locator.dart';
import '../../../../../global/constants/strings/api/apiStrings.dart';
import '../../../../../../global/constants/strings/appStrings/appStrings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SizeConfig _sizeConfig = locator<SizeConfig>();
  SplashBloc _splashBloc = locator<SplashBloc>();
  LocalStorage _localStorage = locator<LocalStorage>();
  EnvironmentModel _environmentModel = locator<EnvironmentModel>();

  UiHelper _uiHelper = locator<UiHelper>();
  bool isOffline = false;
  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  _init() async {
    var status = await OneSignal.shared.getDeviceState();
    String? playerId = status!.userId;
    locator<EnvironmentModel>().oneSignalPlayerId = playerId;
    try {
      //*Onboarding Screen displayer checks
      if (await _localStorage.getLocalValue(
              key: LocalStorageKeys.onboardingStatus) !=
          "True") {
        Navigator.pushNamedAndRemoveUntil(
            context, onboarding, (route) => false);
        _localStorage.setLocalValue(
            key: LocalStorageKeys.onboardingStatus, value: "True");
      }
      //*Onboarding Screen displayer checks

      //*Calling Splash Screen Specific APIS like HomepageAPI, currencyConversion, etc.
      /* else if (await _splashBloc.splashApiCalls()) {
        if (int.tryParse(_environmentModel.appBuildNumber)! <
            _homeBloc.homeApiModelValue.data!.requirements!.buildNumber!) {
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                _homeBloc.homeApiModelValue.data!.requirements!.title!,
                style: Theme.of(context).textTheme.headline2,
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _homeBloc.homeApiModelValue.data!.requirements!.message!,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    _uiHelper.smallHeight,
                    ..._homeBloc
                        .homeApiModelValue.data!.requirements!.changelog!
                        .map((e) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              child: Text(
                                e,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ))
                        .toList()
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => LaunchReview.launch(),
                  child: const Text('Yes'),
                ),
              ],
            ),
          );
        }
      } else {
        setState(() {
          isOffline = true;
        });
      } */
      //*Calling Splash Screen Specific APIS like HomepageAPI, currencyConversion, etc.

      //*Checking for login
      //*Checking Token Validation
      if (await _localStorage.getLocalValue(key: LocalStorageKeys.isLogin) !=
          "True") {
        await _localStorage.deleteLocalValue(key: LocalStorageKeys.username);
        _environmentModel.tokenSet = null;
        _uiHelper.showToast(msg: SplashString.notLogin);
        Navigator.pushNamedAndRemoveUntil(
            context, navigation, (route) => false);
      } else if (await _splashBloc.tokenValidation()) {
       // await _profileBloc.getProfile();
        await _splashBloc.wishAndCartApiCalls();

        //Card offer not now
        //await _splashBloc.cartOffersApiCalls();

       
        Navigator.pushNamedAndRemoveUntil(
            context, navigation, (route) => false);
        //*Calling wishlist and cart api to update UI accordingly
        _uiHelper.showToast(msg: SplashString.welcome);
      } else {
        await _localStorage.deleteLocalValue(key: LocalStorageKeys.token);
        await _localStorage.deleteLocalValue(key: LocalStorageKeys.username);
        _environmentModel.tokenSet = null;
        _uiHelper.showToast(msg: SplashString.notLogin);
        Navigator.pushNamedAndRemoveUntil(
            context, navigation, (route) => false);
      } //*Checking Token Validation

      // if (_environmentModel.token != null) {
      //   try {} catch (e) {}
      // }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isOffline = true;
      });
      _uiHelper.showToast(msg: e.toString(), length: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  WardrobeLogo(
                    padding: _sizeConfig.blockSizeH * 5,
                    height: _sizeConfig.blockSizeH * 45,
                    width: _sizeConfig.blockSizeH * 45,
                  ),
                  Text(
                    SplashString.versionText,
                    style: Theme.of(context).textTheme.subtitle2,
                  )
                ],
              ),
            ),
            isOffline
                ? Positioned(
                    bottom: _sizeConfig.blockSizeH * 10,
                    right: 0,
                    left: 0,
                    child: IconButton(
                      icon: const Icon(Icons.replay_outlined),
                      onPressed: () => _init(),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
