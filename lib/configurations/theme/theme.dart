import 'package:flutter/material.dart';

import '../serviceLocator/locator.dart';
import 'app_colors.dart';
import 'typography.dart';

ThemeData lightTheme(BuildContext context) {
  final SizeConfig sizeConfig = locator<SizeConfig>();
  sizeConfig.init(context);

  return ThemeData(
    primaryColor: AppColors.appPrimary,
    accentColor: AppColors.appSecondary,
    backgroundColor: AppColors.appWhite,
    disabledColor: AppColors.appGrey,
    iconTheme: IconThemeData(color: AppColors.appPrimary),
    scaffoldBackgroundColor: AppColors.appBackgroundColor,
    appBarTheme: AppBarTheme(
      shadowColor: Colors.transparent,
      color: Colors.transparent,
      iconTheme: IconThemeData(
        color: AppColors.appPrimary,
      ),
    ),
    colorScheme: ColorScheme.light(
      // brightness: Brightness.dark,
      background: AppColors.appBackgroundColor,
      surface: AppColors.appSurfaceColor,
      onBackground: AppColors.appOnBackgroundColor,
      onSurface: AppColors.appOnBackgroundColor,
      primary: AppColors.appPrimaryColor,
      primaryVariant: AppColors.appPrimaryVariantColor,
      onPrimary: AppColors.appOnPrimaryColor,
      secondary: AppColors.appSecondaryColor,
      secondaryVariant: AppColors.appSecondaryVariantColor,
      onSecondary: AppColors.appOnSecondaryColor,
      error: AppColors.appErrorColor,
      onError: AppColors.appOnErrorColor,
    ),
    textTheme: lightTextTheme(sizeConfig),
  );
}
