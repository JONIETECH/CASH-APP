import 'package:flutter/material.dart';

class FOutlineButtonTheme {
  FOutlineButtonTheme._();

  // Light theme for outlined buttons
  static final OutlinedButtonThemeData lightOutlineButtonTheme = OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
      side: WidgetStateProperty.all<BorderSide>( const BorderSide(color: Colors.black)),
      textStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(
          shadows: [
            Shadow(
              offset: Offset(-1.5, -1.5),
              color: Colors.white,
            ),
            Shadow(
              offset: Offset(1.5, -1.5),
              color: Colors.white,
            ),
            Shadow(
              offset: Offset(1.5, 1.5),
              color: Colors.white,
            ),
            Shadow(
              offset: Offset(-1.5, 1.5),
              color: Colors.white,
            ),
          ],
        ),
      ),
    ),
  );

  // Dark theme for outlined buttons
  static final OutlinedButtonThemeData darkOutlineButtonTheme = OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      side: WidgetStateProperty.all<BorderSide>(const BorderSide(color: Colors.white)),
      textStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(
          shadows: [
            Shadow(
              offset: Offset(-1.5, -1.5),
              color: Colors.black,
            ),
            Shadow(
              offset: Offset(1.5, -1.5),
              color: Colors.black,
            ),
            Shadow(
              offset: Offset(1.5, 1.5),
              color: Colors.black,
            ),
            Shadow(
              offset: Offset(-1.5, 1.5),
              color: Colors.black,
            ),
          ],
        ),
      ),
    ),
  );
}