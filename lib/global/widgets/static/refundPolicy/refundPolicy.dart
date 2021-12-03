import 'package:wardrobe/global/widgets/static/bloc/staticDataBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../configurations/serviceLocator/locator.dart';

class RefundPolicy extends StatelessWidget {
  final StaticDataBloc _staticDataBloc = locator<StaticDataBloc>();
  final SizeConfig _sizeConfig = locator<SizeConfig>();
  final UiHelper _uiHelper = locator<UiHelper>();
  RefundPolicy() {
    callPrivacyApi();
  }
  callPrivacyApi() async {
    try {
      await _staticDataBloc.fetchRefundPolicy();
    } catch (e) {
      _uiHelper.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PolicyModel>(
        stream: _staticDataBloc.refundPolicy,
        builder: (BuildContext context, AsyncSnapshot<PolicyModel> snapshot) {
          return Container(
            height: _sizeConfig.screenH * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(_sizeConfig.blockSizeH * 5),
                topRight: Radius.circular(_sizeConfig.blockSizeH * 5),
              ),
            ),
            child: snapshot.connectionState == ConnectionState.active
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Html(
                        data: snapshot.data!.data,
                      ),
                    ),
                  )
                : Center(child: _uiHelper.loaderWidget),
          );
        });
  }
}
