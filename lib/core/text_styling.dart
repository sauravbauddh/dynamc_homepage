import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:thematic_ui/core/theme_controller.dart';

class GFonts {
  static const russoOne = GoogleFonts.russoOne;
  static const openSans = GoogleFonts.openSans;
  static const chakraPetch = GoogleFonts.rubik;
}

TextStyle gStyle({
  TextStyle Function()? fontFamily,
  FontWeight? fontWeight,
  double? fontSize,
  Color? color,
  double? height,
  double? letterSpacing,
  TextDecoration? decoration,
  Paint? foreground,
  List<Shadow>? shadows,
  FontStyle? fontStyle,
}) {
  final themeController = Get.find<ThemeController>();

  return (GFonts.chakraPetch)(
    fontWeight: fontWeight ?? FontWeight.normal,
    fontSize: fontSize,
    color: color ??
        (themeController.isDarkMode.value ? Colors.white : Colors.black87),
    height: height,
    letterSpacing: letterSpacing,
    decoration: decoration,
    foreground: foreground,
    shadows: shadows,
    fontStyle: fontStyle,
  );
}
