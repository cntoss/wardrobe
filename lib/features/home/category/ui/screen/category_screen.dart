import 'package:flutter/material.dart';

import '../../../../../configurations/router/router.dart';
import '../../../../../configurations/serviceLocator/locator.dart';

class CategoryScreen extends StatelessWidget {
  final UiHelper _uiHelper = locator<UiHelper>();
  final crossAxisCount = 1;

  CategoryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text('Category');
    /* StreamBuilder<HomeApiModel>(
        stream: _homeBloc.homeApiStream,
        builder: (BuildContext context, AsyncSnapshot<HomeApiModel> snapshot) {
          return !snapshot.hasData
              ? _uiHelper.loaderWidget
              : GridView.builder(
                  clipBehavior: Clip.none,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount, childAspectRatio: 30 / 10),
                  itemCount: snapshot.data!.data!.header!.categories!.items!.length,
                  itemBuilder: (context, index) =>
                      _uiHelper.gridViewBuilderAnimator(
                    index: index,
                    crossAxisCount: crossAxisCount,
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        category,
                        arguments: {
                          "title": snapshot
                              .data!.data!.header!.categories!.items![index].name,
                          "id": snapshot
                              .data!.data!.header!.categories!.items![index].id,
                          "showFilter": true,
                          "isCategory": true,
                          "slug": snapshot
                              .data!.data!.header!.categories!.items![index].slug,
                        },
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white,
                              boxShadow: _uiHelper.boxShadow()),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(snapshot.data!.data!.header!
                                    .categories!.items![index].imageFileName!),
                                Text(
                                  snapshot.data!.data!.header!.categories!
                                      .items![index].name!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                          color: Theme.of(context).accentColor),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
        });
   */
  }
}
