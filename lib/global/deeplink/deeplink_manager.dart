import 'package:wardrobe/configurations/router/router.dart';
import 'package:wardrobe/features/home/navigation/screens/navigation_screen.dart';
import 'package:flutter/material.dart';

import '../../configurations/router/router.dart';

class DeepLinkManager {
  final String? url;

  DeepLinkManager(this.url);

  openPage(BuildContext context) async {
    if (url != null) {
      //url/isNotempty
      try {
        // Uri uri = Uri.parse(url!);
        const NavigationScreen();

        /* if (uri.scheme == "https" || uri.scheme == "http") {
          List<String?> pathSegments = uri.pathSegments;
          if (pathSegments[0] == 'profile' &&
              pathSegments[1] == "orders" &&
              pathSegments[2] == "view-order") {
            Navigator.pushNamed(context, singleOrderHistoryScreen, arguments: {
              "orderId": int.tryParse(pathSegments[3]!),
              "status": null
            });
          } else if (pathSegments[0] == 'product') {
            Navigator.pushNamed(
              context,
              productDetail,
              arguments: {
                'slug': pathSegments[1],
                "id": int.tryParse(pathSegments[1].toString().split("-")[0])
              },
            );
          } else {
          const  NavigationScreen();
          }
        } */
      } catch (e) {
        debugPrint('exception');
      }
    }
  }
}
