import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:flutter/material.dart';

class GlobalTheme {
  static ThemeData buildLightTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      checkboxTheme: const CheckboxThemeData(
          fillColor: MaterialStatePropertyAll(cpPrimaryColorActive)),
      chipTheme: const ChipThemeData(
          backgroundColor: cpChipColor,
          labelStyle: TextStyle(color: Colors.black)),
      cardColor: Colors.white,
      backgroundColor: Colors.white,
      primaryColor: cpPrimaryColor,
      accentColor: cpYellowDarkColor,
      scaffoldBackgroundColor: Colors.white,
    );
  }

  static ThemeData buildDarkTheme() {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      checkboxTheme: const CheckboxThemeData(
          fillColor: MaterialStatePropertyAll(cpPrimaryColorActive)),
      chipTheme: const ChipThemeData(
          backgroundColor: cpYellowDarkColor,
          labelStyle: TextStyle(color: Colors.white)),
      cardColor: Colors.grey[800],
      backgroundColor: Colors.grey[800],
      scaffoldBackgroundColor: Colors.grey[900],
    );
  }
}
