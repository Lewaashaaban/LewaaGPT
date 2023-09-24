// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TOutLinedButtonTheme {
  TOutLinedButtonTheme._();

  static ButtonStyle lightOutlinedButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: Colors.white, // Border color for light theme
    disabledForegroundColor: Colors.black, // Text color for light theme
    padding: EdgeInsets.all(16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    textStyle: TextStyle(fontSize: 18),
  );

  static ButtonStyle darkOutlinedButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: Colors.black, // Border color for dark theme
    backgroundColor: Colors.white, // Text color for dark theme
    padding: EdgeInsets.all(16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    textStyle: TextStyle(fontSize: 18),
  );
}
