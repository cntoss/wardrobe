import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:uni_links/uni_links.dart';
import 'package:wardrobe/features/home/homeindex/ui/screen/home_screen.dart';

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

  final SizeConfig _sizeConfig = locator<SizeConfig>();
  final UiHelper _uiHelper = locator<UiHelper>();
  final SplashBloc _splashBloc = locator<SplashBloc>();
  // final _iconFromAsset = locator<IconFromAsset>();
  // final uiHelper = locator<UiHelper>();
  late int _screen;

  @override
  void initState() {
    super.initState();
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
        appBar: _uiHelper.appBar(context, actions: [IconFromAsset.search]),
      ),
      body: _buildPageView,
      bottomNavigationBar: _buildBtmNavBar(context),
    );
  }

  SnakeNavigationBar _buildBtmNavBar(BuildContext context) {
    return SnakeNavigationBar.color(
      behaviour: SnakeBarBehaviour.floating,
      snakeShape: SnakeShape.indicator,
      padding: const EdgeInsets.all(0),
      snakeViewColor: Theme.of(context).primaryColor,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Theme.of(context).accentColor,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      currentIndex: _screen,
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(
          icon: IconFromAsset.home,
        ),
        BottomNavigationBarItem(
          icon: IconFromAsset.category(3),
        ),
        BottomNavigationBarItem(
          icon: IconFromAsset.user,
        ),
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
