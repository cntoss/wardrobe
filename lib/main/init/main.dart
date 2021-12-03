import 'package:wardrobe/configurations/router/route_config.dart';
import 'package:flutter/material.dart';

import 'package:uni_links/uni_links.dart';

import '../../configurations/router/router.dart';
import '../../configurations/theme/theme.dart';
import '../../global/deeplink/deeplink_manager.dart';

class Wardrobe extends StatefulWidget {
  const Wardrobe({Key? key}) : super(key: key);

  @override
  _WardrobeState createState() => _WardrobeState();
}

class _WardrobeState extends State<Wardrobe> {
  // final UiHelper _uiHelper = locator<UiHelper>();

  initPlatformStateForStringUniLinks(BuildContext context) async {
    // Attach a listener to the links stream
    linkStream.listen((String? link) {
      DeepLinkManager(link)
          .openPage(RouteConfig.navigatorKey.currentState!.context);
    }, onError: (err) {
      debugPrint('got err: on main page');
    });
  }

  @override
  void initState() {
    apiCalls(context);
    super.initState();
  }

  apiCalls(BuildContext context) async {
    try {
      await initPlatformStateForStringUniLinks(context);
    } catch (e) {
      debugPrint('exception');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: RouteConfig.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Ug Bazaar',
      initialRoute: '/',
      onGenerateRoute: router,
      theme: lightTheme(context),
    );
  }
}
