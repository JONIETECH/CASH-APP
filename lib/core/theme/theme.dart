import 'package:flutter/material.dart';
import 'package:new_blogger/core/theme/app_pallete.dart';
import 'package:new_blogger/core/theme/appbar_theme.dart';
import 'package:new_blogger/core/theme/bottomsheet_theme.dart';
import 'package:new_blogger/core/theme/elevated_button.dart';
import 'package:new_blogger/core/theme/outlined_button.dart';
import 'package:new_blogger/core/theme/text_theme.dart';
import 'package:new_blogger/core/theme/textinput_fields.dart';

class AppTheme {
  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPallete.whiteColor,
    primaryColor: AppPallete.gradient1,
    colorScheme: const ColorScheme.light(
      primary: AppPallete.gradient1,
      secondary: AppPallete.gradient2,
    ),
    appBarTheme: AppBarThemes.lightAppBarTheme,
    bottomSheetTheme: FBottomsheetThemes.lightBottomSheetTheme,
    inputDecorationTheme: FTextFieldTheme.lightInputDecorationTheme,
    outlinedButtonTheme: FOutlineButtonTheme.lightOutlineButtonTheme,
    elevatedButtonTheme: FElevatedButtonTheme.lightElevatedButtonTheme,
    buttonTheme: ButtonThemeData(
      buttonColor: AppPallete.gradient1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    textTheme: FTextTheme.lightTextTheme,
    
  );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    primaryColor: AppPallete.gradient2,
    colorScheme: const ColorScheme.dark(
      primary: AppPallete.gradient2,
      secondary: AppPallete.gradient3,
    ),
    appBarTheme: AppBarThemes.darkAppBarTheme,
    bottomSheetTheme: FBottomsheetThemes.darkBottomSheetTheme,
    inputDecorationTheme: FTextFieldTheme.darkInputDecorationTheme,
    outlinedButtonTheme: FOutlineButtonTheme.darkOutlineButtonTheme,
    elevatedButtonTheme: FElevatedButtonTheme.darkElevatedButtonTheme,
    
    
    buttonTheme: ButtonThemeData(
      buttonColor: AppPallete.gradient2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    textTheme: FTextTheme.darkTextTheme
  );
}
