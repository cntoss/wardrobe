import 'package:flutter/material.dart';

import '../../configurations/router/router.dart';
import '../../configurations/serviceLocator/locator.dart';
import '../widgets/formWidgets/app_button.dart';

class PleaseLogin extends StatelessWidget {
  final bool fromProfile;
  PleaseLogin({Key? key, this.fromProfile = false}) : super(key: key);
  final UiHelper _uiHelper = locator<UiHelper>();
  final SizeConfig _sizeConfig = locator<SizeConfig>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _uiHelper.mediumHeight,
            Image.asset('assets/icons/global/no-access.png'),
            _uiHelper.mediumHeight,
            const Text("You need to login to access this area."),
            _uiHelper.smallHeight,
            SizedBox(
              width: _sizeConfig.blockSizeW * 30,
              child: AppButton(
                  initialData: true,
                  title: "Login",
                  act: () async {
                    Navigator.pushNamed(
                      context,
                      login,
                    );
                  }),
            ),
            _uiHelper.largeHeight,
            Expanded(child: _uiHelper.largeHeight),
          ],
        ),
      ),
    );
  }

 }
