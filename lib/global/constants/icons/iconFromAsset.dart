import 'package:flutter/material.dart';

import '../../../configurations/serviceLocator/locator.dart';

class IconFromAsset {
  static final _sizeConfig = locator<SizeConfig>();
  //*Navigation Bar Icons
  static final Widget features = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/navBar/menu.png',
    value: 3,
  );

  static Widget cartWithColor([color]) {
    return ImageParser(
      sizeConfig: _sizeConfig,
      path: 'assets/icons/navBar/cart.png',
      color: color,
    );
  }

  static Widget heartWithColor([color]) {
    return ImageParser(
      sizeConfig: _sizeConfig,
      path: 'assets/icons/global/heart.png',
      color: color,
    );
  }

  static Widget category(double value) => ImageParser(
        sizeConfig: _sizeConfig,
        path: 'assets/icons/navBar/category.png',
        value: value,
      );
  static final Widget cart = ImageParser(
      sizeConfig: _sizeConfig, path: 'assets/icons/navBar/cart.png', value: 3);
  static final Widget home = ImageParser(
      sizeConfig: _sizeConfig, path: 'assets/icons/navBar/home.png', value: 3);
  static final Widget user = ImageParser(
      sizeConfig: _sizeConfig, path: 'assets/icons/navBar/user.png', value: 3);
  //*Menu Icons
  static final Widget auction = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/menu/auction.png',
    value: 5,
  );
  static final Widget search = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/navBar/search.png',
    value: 3,
  );

  static final Widget campaign = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/menu/campaign.png',
    value: 5,
  );
  static final Widget contest = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/menu/contest.png',
    value: 4,
  );
  static final Widget blog = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/menu/blog.png',
    value: 4,
  );
  static final Widget quiz = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/menu/quiz.png',
    value: 4,
  );
  static final Widget feedback = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/menu/feedback.png',
    value: 4,
  );
  static final Widget career = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/menu/career.png',
    value: 5,
  );
  static final Widget automobile = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/menu/automobile.png',
    value: 4,
  );

  //*Profile Icons
  static final Widget contactUs = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/profile/contactUs.png',
    value: 5,
  );
  static final Widget security = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/profile/security.png',
    value: 5,
  );
  static final Widget bio = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/profile/thought-bubble.png',
    value: 1,
  );
  static final Widget myAddress = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/profile/myAddresses.png',
    value: 5,
  );
  static final Widget orderHistory = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/profile/orderHistory.png',
    value: 5,
  );
  static final Widget edit = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/profile/edit.png',
    value: 5,
  );
  static final Widget editx3 = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/profile/edit.png',
    value: 3,
  );
  static final Widget view = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/profile/profile.png',
    value: 5,
  );
  static final Widget rateUs = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/profile/rateUs.png',
    value: 5,
  );
  static final Widget wishlist = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/profile/wishlist.png',
    value: 4,
  );

  //*Automobile Icons
  static final Widget battery = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/automobile/battery.png',
    value: 5,
  );
  static final Widget engine = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/automobile/engine.png',
    value: 5,
  );
  static final Widget maxpower = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/automobile/maxpower.png',
    value: 5,
  );
  static final Widget maxtorque = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/automobile/maxtorque.png',
    value: 5,
  );
  static final Widget mileage = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/automobile/mileage.png',
    value: 5,
  );
  static final Widget range = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/automobile/range.png',
    value: 5,
  );
  static final Widget topspeed = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/automobile/topspeed.png',
    value: 5,
  );
  static final Widget warranty = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/automobile/warranty.png',
    value: 5,
  );
  //*Automobile Icons

  //*Global Icons
  static final Widget login = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/global/login.png',
  );
  static final Widget delete = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/global/delete.png',
    value: 3,
  );
  static final Widget cartEmpty = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/global/cart-empty.png',
    value: 3,
  );

  static final Widget heart = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/global/heart.png',
  );

  static final Widget location = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/global/location.png',
    value: 3,
  );
  static final Widget addToCart = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/global/add-to-cart.png',
    value: 3,
  );
  static final Widget logout = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/global/logout.png',
    value: 5,
  );

  static final Widget remove = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/global/cross.png',
    value: 2,
  );

  static final Widget plus = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/global/plus.png',
    value: 2,
  );

  //*For Order History
  //old style
/*   static final Widget qcStroke = ImageParser(
    sizeConfig: _sizeConfig,
    path: 'assets/icons/orders/qc-stroke.png',
    value: 5,
  ); */
  static final Widget qcFill =
      _directImage(path: 'assets/icons/orders/qc-fill.png');
  static final Widget qcStroke = _directImage(
    path: 'assets/icons/orders/qc-stroke.png',
  );
  static final Widget deliveredFill =
      _directImage(path: 'assets/icons/orders/delivered-fill.png');
  static final Widget deliveredStroke = _directImage(
    path: 'assets/icons/orders/delivered-stroke.png',
  );
  static final Widget confirmedFill =
      _directImage(path: 'assets/icons/orders/confirmed-fill.png');
  static final Widget confirmedStroke = _directImage(
    path: 'assets/icons/orders/confirmed-stroke.png',
  );
  static final Widget processingFill =
      _directImage(path: 'assets/icons/orders/processing-fill.png');

  static final Widget processingStroke = _directImage(
    path: 'assets/icons/orders/processing-stroke.png',
  );
  static final Widget reviewFill =
      _directImage(path: 'assets/icons/orders/review-fill.png');
  static final Widget reviewStroke = _directImage(
    path: 'assets/icons/orders/review-stroke.png',
  );

  static final Widget current = _directImage(
    path: 'assets/icons/orders/profile/current.png',
  );
  static final Widget deliverd = _directImage(
    path: 'assets/icons/orders/profile/delivered.png',
  );
  static final Widget cancelled = _directImage(
    path: 'assets/icons/orders/profile/cancelled.png',
  );
  static final Widget refund = _directImage(
    path: 'assets/icons/orders/profile/refund.png',
  );

  static final Widget myOrder = _drawerImage(
    path: 'assets/icons/drawer/myOrder.png',
  );

  static final Widget leaveFeedback = _drawerImage(
    path: 'assets/icons/drawer/feedback.png',
  );

  static final Widget drawerContact = _drawerImage(
    path: 'assets/icons/drawer/contactUs.png',
  );
  static final Widget cakeFinder = _drawerImage(
    path: 'assets/icons/drawer/cakeFinder.png',
  );

  static final Widget roulette = _drawerImage(
    path: 'assets/icons/drawer/roulette.png',
  );

  static final Widget referral = _drawerImage(
    path: 'assets/icons/drawer/referral.png',
  );
  static final Widget drawerCareer = _drawerImage(
    path: 'assets/icons/drawer/career.png',
  );
  static final Widget leaveFeadback = _drawerImage(
    path: 'assets/icons/drawer/feedback.png',
  );
  static final Widget rateThisApp = _drawerImage(
    path: 'assets/icons/drawer/rateUs.png',
  );
  static final Widget aboutUs = _drawerImage(
    path: 'assets/icons/drawer/aboutUs.png',
  );
  static final Widget privacyPolicy = _drawerImage(
    path: 'assets/icons/drawer/privacyPolicy.png',
  );
  static final Widget drawerLogout = _drawerImage(
    path: 'assets/icons/drawer/logout.png',
  );
  static Widget drawerCategory(double size) => ImageIcon(
        AssetImage(
          'assets/icons/navBar/category.png',
        ),
        size: size,
      );
  //assets/icons/navBar/category.png
  static Widget eye([Color? color, double value = 2]) => ImageParser(
        sizeConfig: _sizeConfig,
        color: color ?? Colors.grey,
        path: 'assets/icons/product and store/eye-fill.png',
        value: value,
      );

  static Widget whiteEgg([Color? color, double value = 4]) => ImageParser(
        sizeConfig: _sizeConfig,
        color: color ?? Colors.grey,
        path: 'assets/icons/cake_finder/eggWhite.png',
        value: value,
      );

  static Widget redEgg([Color? color, double value = 4]) => ImageParser(
        sizeConfig: _sizeConfig,
        color: color ?? Colors.red,
        path: 'assets/icons/cake_finder/eggRed.png',
        value: value,
      );
  static Widget tier(int index, {Color? color, double value = 6}) =>
      ImageParser(
        sizeConfig: _sizeConfig,
        color: color ?? Colors.red,
        path: 'assets/icons/cake_finder/tier_$index.png',
        value: value,
      );

  static Padding _directImage({required String path}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _sizeConfig.blockSizeW * 3),
      child: Image.asset(
        path,
        height: _sizeConfig.blockSizeW * 10,
      ),
    );
  }

  static _drawerImage({required String path}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _sizeConfig.blockSizeW * 3),
      child: Image.asset(
        path,
      ),
    );
  }
}

class ImageParser extends StatelessWidget {
  const ImageParser({
    Key? key,
    required this.sizeConfig,
    required this.path,
    this.value = 2.5,
    this.color,
  }) : super(key: key);

  final SizeConfig sizeConfig;
  final String path;
  final double value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizeConfig.blockSizeW * 2),
      child: ImageIcon(
        AssetImage(
          path,
        ),
        color: color,
        size: sizeConfig.blockSizeH * value,
      ),
    );
  }
}
