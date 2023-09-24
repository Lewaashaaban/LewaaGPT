// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my/src/constants/colors.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static ButtonStyle lightButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: tSecondaryColor, // Change to black color for light theme
    foregroundColor: Colors.white, // Text color for light theme
    padding: EdgeInsets.all(16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    textStyle: TextStyle(fontSize: 18),
  );

  static ButtonStyle darkButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: tPrimaryColor, // Change to yellow color for dark theme
    foregroundColor: Colors.black, // Text color for dark theme
    padding: EdgeInsets.all(16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    textStyle: TextStyle(fontSize: 18),
  );
}
