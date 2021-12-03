import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wardrobe/global/constants/images/logo.dart';

import '../../../configurations/serviceLocator/locator.dart';
import '../../../configurations/theme/app_colors.dart';
import '../../../features/auth/splash/model/currency_conversion_model.dart';

export 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

final SizeConfig _sizeConfig = locator<SizeConfig>();

class UiHelper {
  CurrencyConversionModel? _currencyConversionModel;
  apiCalls() async {
    await locator<SplashBloc>().callCurrencyConversion().then((value) {
      _currencyConversionModel = locator<SplashBloc>().cModel;
    });
  }

  UiHelper() {
    apiCalls();
  }

  //*Preset heights and width for gapings
  final SizedBox extraSmallHeight = SizedBox(
    height: _sizeConfig.blockSizeW,
  );
  final SizedBox smallHeight = SizedBox(
    height: _sizeConfig.blockSizeH * 1.5,
  );
  final SizedBox mediumHeight = SizedBox(
    height: _sizeConfig.blockSizeH * 5,
  );
  final SizedBox largeHeight = SizedBox(
    height: _sizeConfig.blockSizeH * 8,
  );
  final SizedBox smallWidth = SizedBox(
    width: _sizeConfig.blockSizeW * 1.5,
  );
  final SizedBox mediumWidth = SizedBox(
    width: _sizeConfig.blockSizeW * 5,
  );
  final SizedBox largeWidth = SizedBox(
    width: _sizeConfig.blockSizeW * 8,
  );
  //*Preset heights and width for gapings

  //*Default goto divider
  Divider divider({color}) {
    return Divider(
      thickness: 1,
      color: color,
      indent: _sizeConfig.blockSizeW,
      endIndent: _sizeConfig.blockSizeW,
    );
  }
  //*Default goto divider

  //*Pricing
  String priceToString(double price) {
    if (_currencyConversionModel != null) {
      final String actualPrice =
          (price * _currencyConversionModel!.data!.factor!)
              .toStringAsFixed(_currencyConversionModel!.data!.round!);
      return '${_currencyConversionModel!.data!.currency} $actualPrice';
    } else {
      apiCalls();
      return '';
    }
  }

  String convertedPrice(int price) {
    if (_currencyConversionModel != null) {
      return (price * _currencyConversionModel!.data!.factor!)
          .toStringAsFixed(_currencyConversionModel!.data!.round!);
    } else {
      apiCalls();
      return '';
    }
  }

  int? reversePrice(int? price) {
    if (price != null) {
      if (_currencyConversionModel != null) {
        return (price ~/ _currencyConversionModel!.data!.factor!).toInt();
      } else {
        apiCalls();
        return 0;
      }
    } else
      return null;
  }

  String ampm(String? t) {
    if (t != null) {
      List times = t.split(':');
      String x = times[0];
      if (int.parse(x) <= 11)
        return '$x:${times[1]} AM';
      else if (x == '12')
        return '12:${times[1]} PM';
      else
        return '${(int.parse(x) - 12).toString()}:${times[1]} PM';
    } else
      return '';
  }

  double priceToDouble(price) {
    return (price * _currencyConversionModel!.data!.factor)
        .toStringAsFixed(_currencyConversionModel!.data!.round) as double;
  }
  //*Pricing

  //*Showing App Toast
  showToast(
      {required String msg, bool length = true, bool gravityBottom = true}) {
    Fluttertoast.showToast(
      toastLength: length
          ? Toast.LENGTH_SHORT
          : Toast.LENGTH_LONG, //true for short || false for long
      msg: msg,
      gravity: gravityBottom ? ToastGravity.BOTTOM : ToastGravity.TOP,
      backgroundColor: AppColors.appPrimary,
    );
  }
  //*Showing App Toast

  //*Common AppBar
  PreferredSize appBar(
    BuildContext context, {
    String? title,
    List<Widget>? actions,
    Widget? bottom,
    double size = 5,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(_sizeConfig.blockSizeH * size),
      child: AppBar(
        bottom: bottom == null ? null : bottom as PreferredSizeWidget,
        backgroundColor: Theme.of(context).backgroundColor,
        actions: actions,
        centerTitle: true,
        title: title == null
            ? WardrobeLogo(
                padding: 0,
                height: _sizeConfig.blockSizeH * 18,
                width: _sizeConfig.blockSizeH * 18,
              )
            : Text(title, style: Theme.of(context).textTheme.headline1),
      ),
    );
  }
  //*Common AppBar

  //*Apps default boxshadow
  boxShadow() {
    return [
      BoxShadow(
        offset: Offset(0, 7),
        blurRadius: 7,
        spreadRadius: 1,
        color: AppColors.appShadow.withOpacity(0.40),
      ),
    ];
  }
  //*Apps default boxshadow

  //*Price Converter
  priceToText(price) {
    if (price > 10000000) {
      return (price / 10000000).toStringAsFixed(2) + ' crore';
    } else if (price > 100000) {
      return (price / 100000).toStringAsFixed(2) + ' lakh';
    } else {
      return price;
    }
  }
  //*Price Converter

  //*Showing App Loader
  showLoader(context) {
    showDialog(
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Image.asset(
            "assets/icons/global/loader.gif",
            height: _sizeConfig.blockSizeW * 10,
            width: _sizeConfig.blockSizeW * 10,
          ),
        );
      },
    );
  }

  Widget loaderWidget = Center(
    child: Image.asset(
      "assets/icons/global/loader.gif",
      height: _sizeConfig.blockSizeW * 10,
      width: _sizeConfig.blockSizeW * 10,
    ),
  );

  //*To add shimmers
  addShimmer({Widget? child}) {
    return Shimmer.fromColors(
        child: child!,
        baseColor: AppColors.appShimmerBackground,
        highlightColor: AppColors.appBackgroundColor);
  }

  //*Date Formatter
  //?YYYY-MM-DD format (2020-02-20)
  String formatDate(DateTime data) {
    return DateFormat('yyyy-MM-dd').format(data);
  }

  String formatDateTextual(DateTime data) {
    return DateFormat('MMM d, yyyy').format(data);
  }
  //*Date Formatter

  //*Hiding keyboard
  hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
  //*Hiding keyboard

  //*ListView animator
  listViewAnimator({required List<Widget> children}) {
    return AnimationConfiguration.toStaggeredList(
        duration: const Duration(milliseconds: 400),
        childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
        children: children);
  }
  //*ListView animator

  //*ListViewBuilder animator
  listViewBuilderAnimator({
    required Widget child,
    required int index,
  }) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 100.0,
        child: FadeInAnimation(
          child: child,
        ),
      ),
    );
  }
  //*ListViewBuilder animator

  //*GridViewBuilder animator
  gridViewBuilderAnimator(
      {required Widget child, required int index, required crossAxisCount}) {
    return AnimationConfiguration.staggeredGrid(
      position: index,
      duration: const Duration(milliseconds: 150),
      columnCount: crossAxisCount,
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: child,
        ),
      ),
    );
  }
  //*GridViewBuilder animator

}
