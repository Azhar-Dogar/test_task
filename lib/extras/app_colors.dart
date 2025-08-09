import 'package:flutter/material.dart';
import 'package:utility_extensions/extensions/color_utilities.dart';

class AppColors {
  static const primary = Color(0xff000000);
  static const black = Color(0xff0C0C0C00);
  static const white = Color(0xffFFFFFf);
  static const white2 = Color(0xffF2F2F2);

  static  LinearGradient blackGradient = LinearGradient(
    colors: [
      black.applyOpacity(0),
      black.applyOpacity(1),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );


  static MaterialColor getMaterialColor(Color color) {
    return MaterialColor(color.value, AppColors.getSwatch(color));
  }

  static Map<int, Color> getSwatch(Color color) {
    final hslColor = HSLColor.fromColor(color);
    final lightness = hslColor.lightness;
    const lowDivisor = 6;
    const highDivisor = 5;
    final lowStep = (1.0 - lightness) / lowDivisor;
    final highStep = lightness / highDivisor;
    return {
      50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
      100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
      200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
      300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
      400: (hslColor.withLightness(lightness + lowStep)).toColor(),
      500: (hslColor.withLightness(lightness)).toColor(),
      600: (hslColor.withLightness(lightness - highStep)).toColor(),
      700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
      800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
      900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
    };
  }
}
