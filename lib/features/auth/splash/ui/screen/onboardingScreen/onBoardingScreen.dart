import '../../../../../../configurations/router/router.dart';
import '../../../../../../configurations/serviceLocator/locator.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  final UiHelper _uiHelper = locator<UiHelper>();
  final List onBoardingData = [
    {
      "title": "Welcome to UG Bazaar !",
      "image": "assets/images/safe_delivery.png",
      "desc": "UG Bazaar is on the way to serve you. "
    },
    {
      "title": "Variety of Products",
      "image": "assets/images/variety_of_products.png",
      "desc":
          "See all things happening around you just by a click in your phone. "
              "Fast, convenient and clean."
    },
    {
      "title": "Online Payment",
      "image": "assets/images/online_payment.png",
      "desc": "Waiting no more, payment from your phone!"
    },
  ];

  final List<PageViewModel> _pageViewModels = [];

  @override
  Widget build(BuildContext context) {
    PageViewModel loginWidget = PageViewModel(
        title: onBoardingData[2]['title'],
        decoration: PageDecoration(
          titleTextStyle: Theme.of(context).textTheme.headline5!,
          bodyTextStyle: Theme.of(context).textTheme.bodyText1!,
        ),
        image: Center(
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  onBoardingData[2]['image'],
                ),
              ),
            ),
          ),
        ),
        bodyWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, login, (route) => false, arguments: true);
                    },
                  ),
                  Text(
                    "    |    ",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  GestureDetector(
                    child: Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, login, (route) => false, arguments: true);
                    },
                  ),
                ],
              ),
            ),
            _uiHelper.smallHeight,
            Text(
              onBoardingData[2]['desc'],
            )
          ],
        ));
    for (int i = 0; i < onBoardingData.length; i++) {
      PageViewModel model = PageViewModel(
        title: onBoardingData[i]['title'],
        decoration: PageDecoration(
          titleTextStyle: Theme.of(context).textTheme.headline5!,
          bodyTextStyle: Theme.of(context).textTheme.bodyText1!,
        ),
        body: onBoardingData[i]['desc'],
        image: Center(
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  onBoardingData[i]['image'],
                ),
              ),
            ),
          ),
        ),
      );
      if (i == 2) {
        model = loginWidget;
      }
      _pageViewModels.add(model);
    }
    return IntroductionScreen(
      onDone: () =>
          Navigator.pushNamedAndRemoveUntil(context, splash, (route) => false),
      pages: _pageViewModels,
      showSkipButton: true,
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: Theme.of(context).accentColor,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      skip: Text("Skip"),
      showNextButton: true,
      next: Text("Next"),
      done: Text("Done"),
    );
  }
}
