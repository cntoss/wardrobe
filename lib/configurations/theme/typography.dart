import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../serviceLocator/locator.dart';
import 'app_colors.dart';

TextTheme lightTextTheme(SizeConfig sizeConfig) {
  final double fontSizeL = sizeConfig.blockSizeW * 5;
  final double fontSizeL2 = sizeConfig.blockSizeW * 4;
  final double fontSizeM = sizeConfig.blockSizeW * 3;
  final double fontSizeM2 = sizeConfig.blockSizeW * 3.5;

  final double fontSizeS = sizeConfig.blockSizeW * 2.8;
  final double fontSizeXS = sizeConfig.blockSizeW * 2.2;

  return TextTheme(
    headline1: GoogleFonts.poppins(
      fontSize: fontSizeL2,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.5,
      color: AppColors.appBlack,
    ),
    headline2: GoogleFonts.poppins(
      fontSize: fontSizeL,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.5,
    ),
    headline3: GoogleFonts.poppins(
      fontSize: fontSizeM,
      fontWeight: FontWeight.w400,
    ),
    headline4: GoogleFonts.poppins(
      fontSize: fontSizeM2,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.20,
      color: AppColors.appBlack,
    ),
    headline5: GoogleFonts.poppins(
      fontSize: fontSizeL,
      fontWeight: FontWeight.w600,
      color: AppColors.appBlack,
    ),
    headline6: GoogleFonts.poppins(
      fontSize: fontSizeM,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    subtitle1: GoogleFonts.poppins(
      fontSize: fontSizeM,
      fontWeight: FontWeight.w400,
      color: AppColors.appGrey,
      letterSpacing: 0.15,
    ),
    subtitle2: GoogleFonts.poppins(
      fontSize: fontSizeS,
      fontWeight: FontWeight.w500,
      color: AppColors.appPrimary,
      letterSpacing: 0.1,
    ),
    bodyText1: GoogleFonts.poppins(
      fontSize: fontSizeS,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.30,
    ),
    bodyText2: GoogleFonts.poppins(
      fontSize: fontSizeS,
      fontWeight: FontWeight.w400,
      color: AppColors.appGrey,
      letterSpacing: 0.25,
    ),
    button: GoogleFonts.poppins(
      fontSize: fontSizeM,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
    ),
    caption: GoogleFonts.poppins(
      fontSize: fontSizeS,
      color: AppColors.appGrey,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
    overline: GoogleFonts.poppins(
      fontSize: fontSizeXS,
      color: AppColors.appGrey,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
    ),
  );
}
