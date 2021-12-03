//import 'package:wardrobe/features/home/profile/myAddresses/ui/screen/baatoMap.dart';

import 'package:flutter/material.dart';
import 'package:wardrobe/features/auth/forgot_password/ui/screen/forgot_password_screen.dart';
import 'package:wardrobe/features/auth/verification/email_verification/ui/screen/email_pin_verification_screen.dart';
import 'package:wardrobe/features/auth/verification/phone_verification/ui/screen/phone_pin_verification_screen.dart';

import '../../features/auth/login/ui/screen/login_screen.dart';
import '../../features/auth/register/ui/screen/register_screen.dart';
import '../../features/auth/splash/ui/screen/onboardingScreen/onBoardingScreen.dart';
import '../../features/auth/splash/ui/screen/splash_screen.dart';
import '../../features/home/navigation/screens/navigation_screen.dart';
import '../../global/widgets/static/contactUs/contactUs.dart';

//*Initial Screens
const String splash = '/';
const String onboarding = '/onboarding';
const String navigation = '/navigation';
const String home = '/home';
const String profile = '/profile';
const String login = '/login';
const String phonePinVerification = '/phone-pin-verification';
const String emailPinVerification = '/email-pin-verification';
const String register = '/register';
const String forgotPassword = '/forgot-password';

//*From Menu
//*From Profile
const String changePassword = 'profile/change-password';
const String contact = 'profile/contact';

//*From Product

const String category = '/category';

MaterialPageRoute router(RouteSettings settings) {
  // return PageRouteBuilder(
  //   transitionDuration: Duration(milliseconds: 200),
  //   transitionsBuilder: (context, animation, animationTime, child) {
  //     animation =
  //         CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
  //     return ScaleTransition(
  //       scale: animation,
  //       alignment: Alignment.topCenter,
  //       child: child,
  //     );
  //   },
  //   pageBuilder: (context, animation, animationTime) {
  return MaterialPageRoute(
    builder: (context) {
      switch (settings.name) {
        //*Auth Based routes
        case splash:
          // return LoginScreen();
          return const SplashScreen();
        case onboarding:
          return OnBoardingScreen();
        case navigation:
          {
            final int? _arguments =
                settings.arguments != null ? settings.arguments as int : null;
            return NavigationScreen(
              screen: _arguments,
            );
          }

        case login:
          return LoginScreen(
            routeToSplash:
                settings.arguments != null ? settings.arguments as bool : null,
          );
        case phonePinVerification:
          Map<String, dynamic> _arguments =
              settings.arguments as Map<String, dynamic>;
          return PhonePinVerificationScreen(
            isPhone: _arguments['isPhone'],
            token: _arguments['token'],
            fromRegister: _arguments['fromRegister'],
            verificationId: _arguments['verificationId'],
            countryCode: _arguments['countryCode'],
            phoneNo: _arguments['phoneNo'],
            email: _arguments['email'],
          );
        case emailPinVerification:
          String _email = settings.arguments as String;
          return EmailPinVerificationScreen(
            email: _email,
          );

        case register:
          return RegisterScreen();

        case forgotPassword:
          return ForgotPasswordScreen();

        //*Auth Based routes

        //*Profile based routes
       
        case contact:
          return ContactUsScreen();
       
        default:
          return const DefaultScreen();
      }
    },
  );
}

class DefaultScreen extends StatelessWidget {
  const DefaultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Comming Soon...",
            style: Theme.of(context).textTheme.headline1),
      ),
    );
  }
}
