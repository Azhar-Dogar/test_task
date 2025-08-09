import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';


class AppTextStyles {
  static TextStyle playFairDisplay({TextStyle? style}) {
    return GoogleFonts.playfairDisplay(textStyle: style);
  }

  static TextStyle poppins({TextStyle? style}) {
    return GoogleFonts.poppins(textStyle: style);
  }

  static TextStyle regular({Color? color = AppColors.black,double? fontSize}) {
    return playFairDisplay(
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: color,
        fontSize:fontSize ?? 16,
      ),
    );
  }

  static TextStyle poppinsRegular({Color? color = AppColors.primary,double? fontSize}) {
    return poppins(
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: color,
        fontSize:fontSize ?? 16,
      ),
    );
  }

  static TextStyle semiBold({Color? color = AppColors.white,double? fontSize}) {
    return playFairDisplay(
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: color,
        fontSize:fontSize ?? 14,
      ),
    );
  }

  static TextStyle poppinsSemiBold({Color? color = AppColors.white,double? fontSize}) {
    return poppins(
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: color,
        fontSize:fontSize ?? 14,
      ),
    );
  }

}
