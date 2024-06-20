import 'package:flutter/material.dart';
import 'package:new_blogger/core/theme/app_pallete.dart';

class AppTheme {
  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPallete.whiteColor,
    primaryColor: AppPallete.gradient1,
    colorScheme: const ColorScheme.light(
      primary: AppPallete.gradient1,
      secondary: AppPallete.gradient2,
    ),
    appBarTheme: const AppBarTheme(
      color: AppPallete.gradient1,
      iconTheme: IconThemeData(color: AppPallete.whiteColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: AppPallete.borderColor,width: 3),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: AppPallete.gradient1),
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppPallete.gradient1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppPallete.greyColor),
      bodyMedium: TextStyle(color: AppPallete.greyColor),
    ),
  );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    primaryColor: AppPallete.gradient2,
    colorScheme: const ColorScheme.dark(
      primary: AppPallete.gradient2,
      secondary: AppPallete.gradient3,
    ),
    appBarTheme: const AppBarTheme(
      color: AppPallete.backgroundColor,
      iconTheme: IconThemeData(color: AppPallete.whiteColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: AppPallete.borderColor,width: 3),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: AppPallete.gradient2),
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppPallete.gradient2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppPallete.whiteColor),
      bodyMedium: TextStyle(color: AppPallete.whiteColor),
    ),
  );
}
