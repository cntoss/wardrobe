import 'package:flutter/widgets.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  late double screenW;
  late double screenH;
  late double blockSizeW;
  late double blockSizeH;

  late double _safeAreaW;
  late double _safeAreaH;
  late double safeBlockW;
  late double safeBlockH;

  late double hrPadding;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenW = _mediaQueryData.size.width;
    screenH = _mediaQueryData.size.height;
    blockSizeW = screenW / 100;
    blockSizeH = screenH / 100;

    _safeAreaW = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaH = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockW = (screenW - _safeAreaW) / 100;
    safeBlockH = (screenH - _safeAreaH) / 100;
    hrPadding = blockSizeW * 3;
  }
}
