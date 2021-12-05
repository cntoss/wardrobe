import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:uni_links/uni_links.dart';
import 'package:wardrobe/configurations/theme/app_colors.dart';
import 'package:wardrobe/features/home/homeindex/ui/screen/home_screen.dart';
import 'package:wardrobe/features/home/notification/ui/page/notification_screen.dart';
import 'package:wardrobe/features/home/navigation/screens/widget/fab_button.dart';

import '../../../../configurations/serviceLocator/locator.dart';
import '../../../../global/deeplink/deeplink_manager.dart';
import '../../category/ui/screen/category_screen.dart';
import '../../profile/profileIndex/ui/screen/profile_screen.dart';
import 'widget/custom_appbar.dart';

// ignore: must_be_immutable
class NavigationScreen extends StatefulWidget {
  final PreferredSizeWidget? appBar;
  final int? screen;

  const NavigationScreen({Key? key, this.appBar, this.screen = 0})
      : super(key: key);
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  late PageController _pageController;
  final _home = const HomeScreen();
  final _category = CategoryScreen();
  final _profile = const ProfileScreen();
  final _notification = const NotificationScreen();

  final SizeConfig _sizeConfig = locator<SizeConfig>();
  final UiHelper _uiHelper = locator<UiHelper>();
  final SplashBloc _splashBloc = locator<SplashBloc>();
  // final _iconFromAsset = locator<IconFromAsset>();
  // final uiHelper = locator<UiHelper>();
  late int _screen;

  @override
  void initState() {
    super.initState();
    _screen = widget.screen ?? 1;
    _pageController = PageController(initialPage: _screen);
    initUniLinks(context);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  Future<Null> initUniLinks(BuildContext ctx) async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final appUrl = await getInitialLink();
      if (appUrl != null) {
        await DeepLinkManager(appUrl).openPage(ctx);
      }
    } catch (e) {
      _uiHelper.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        onTap: () {
          /* showSearch(
              context: context, delegate: AppSearchDelegate(searchFrom: "")); */
        },
        appBar: _uiHelper.appBar(context),
      ),
      body: _buildPageView,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {},
        tooltip: 'Increment',
        child: Column(
          children: [
            Transform.rotate(
              angle: -2.2,
              child: Column(
                children: [
                  Icon(
                    Icons.label_outlined,
                    size: _sizeConfig.safeBlockW * 8,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            const Text('Sell')
          ],
        ),
        elevation: 4.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          notchMargin: 5.0,
          elevation: 4,
          shape: const CircularNotchedRectangle(),
          child: _buildBtmNavBar(context)),
    );
  }

  _buildBtmNavBar(BuildContext context) {
    return FABBottomAppBar(
      centerItemText: 'A',
      notchedShape: const CircularNotchedRectangle(),
      onTabSelected: _onItemTapped,
      selectedColor: Theme.of(context).primaryColor,
      color: Theme.of(context).accentColor,
      backgroundColor: Colors.white,
      items: [
        FABBottomAppBarItem(iconData: Icons.home_outlined, text: 'Home'),
        FABBottomAppBarItem(iconData: Icons.apps_outlined, text: 'Category'),
        FABBottomAppBarItem(
            iconData: Icons.notification_add_rounded, text: 'Notification'),
        FABBottomAppBarItem(iconData: Icons.person_outline, text: 'Profile'),
      ],
    );
  }

  PageView get _buildPageView {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      onPageChanged: (index) {
        setState(
          () => _screen = index,
        );
      },
      children: [
        _home,
        _category,
        _notification,
        _profile,
      ],
    );
  }

  //
  void _onItemTapped(int index) {
    setState(() {
      _screen = index;

      _pageController.jumpToPage(
        index,
      );
    });
  }
}
