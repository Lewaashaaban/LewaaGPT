// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my/src/constants/colors.dart';
import 'package:my/src/theme/widget_themes/elevated_button_theme.dart';
import 'package:my/src/theme/widget_themes/outlined_button_theme.dart';
import 'package:my/src/theme/widget_themes/text_field_theme.dart';
import 'package:my/src/theme/widget_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      textTheme: TTextTheme.lightTextTheme,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: TOutLinedButtonTheme.lightOutlinedButtonStyle,
      ),
      inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: TElevatedButtonTheme.lightButtonStyle),
      appBarTheme: AppBarTheme(color: tPrimaryColor));

  static ThemeData darktheme = ThemeData(
      brightness: Brightness.dark,
      textTheme: TTextTheme.darkTextTheme,
      inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: TElevatedButtonTheme.darkButtonStyle),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: TOutLinedButtonTheme.darkOutlinedButtonStyle,
      ),
      appBarTheme: AppBarTheme(color: tPrimaryColor));
}
