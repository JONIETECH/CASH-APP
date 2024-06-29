import 'package:flutter/material.dart';

class AppPallete {
  AppPallete._();

  // App Basic Colors
  static const Color primaryColor = Color(0xFF4b68ff);
  static const Color secondary = Color(0xFF60c7ff);
  static const Color accent = Color(0xFFb00020);

  // Text Colors
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textAccent = Color(0xFFFFFFFF);

  // Gradient Colors
  static const Color gradientStart = Color(0xFF4b68ff);
  static const Color gradientEnd = Color(0xFF60c7ff);

  // Background Colors
  static const Color backgroundPrimary = Color(0xFFFFFFFF);
  static const Color backgroundSecondary = Color(0xFFF5F5F5);

  // Background Container Colors
  static const Color containerBackground = Color(0xFFE0E0E0);
  static const Color containerShadow = Color(0xFFBDBDBD);

  // Buttons Colors
  static const Color buttonPrimary = Color(0xFF4b68ff);
  static const Color buttonSecondary = Color(0xFF60c7ff);
  static const Color buttonText = Color(0xFFFFFFFF);

  // Border Colors
  static const Color borderPrimary = Color(0xFF4b68ff);
  static const Color borderSecondary = Color(0xFF60c7ff);

  // Error and Validation Colors
  static const Color error = Color(0xFFb00020);
  static const Color validation = Color(0xFF00c853);

  // Neutral Shades
  static const Color neutralDark = Color(0xFF212121);
  static const Color neutralLight = Color(0xFFFAFAFA);

  // Dark Theme Colors
  static final DarkColors dark = DarkColors();

  // Light Theme Colors
  static final LightColors light = LightColors();

  // App Palette Colors
  static const Color backgroundColor = Colors.black;
  static const Color gradient1 = Colors.black;
  static const Color gradient2 = Colors.black;
  static const Color gradient3 = Color.fromRGBO(255, 159, 124, 1);
  static const Color borderColor = Color.fromRGBO(52, 51, 67, 1);
  static const Color whiteColor = Colors.white;
  static const Color greyColor = Colors.grey;
  static const Color errorColor = Colors.redAccent;
  static const Color transparentColor = Colors.transparent;
}

class DarkColors {
  // Dark Theme Colors
  final Color primaryColor = Color(0xFF1a237e);
  final Color secondary = Color(0xFF0288d1);
  final Color accent = Color(0xFFd32f2f);

  final Color textPrimary = Color(0xFFFFFFFF);
  final Color textSecondary = Color(0xFFbdbdbd);
  final Color textAccent = Color(0xFF000000);

  final Color gradientStart = Color(0xFF1a237e);
  final Color gradientEnd = Color(0xFF0288d1);

  final Color backgroundPrimary = Color(0xFF303030);
  final Color backgroundSecondary = Color(0xFF424242);

  final Color containerBackground = Color(0xFF616161);
  final Color containerShadow = Color(0xFF757575);

  final Color buttonPrimary = Color(0xFF1a237e);
  final Color buttonSecondary = Color(0xFF0288d1);
  final Color buttonText = Color(0xFFFFFFFF);

  final Color borderPrimary = Color(0xFF1a237e);
  final Color borderSecondary = Color(0xFF0288d1);

  final Color error = Color(0xFFd32f2f);
  final Color validation = Color(0xFF00e676);

  final Color neutralDark = Color(0xFF212121);
  final Color neutralLight = Color(0xFFFAFAFA);
}

class LightColors {
  // Light Theme Colors
  final Color primaryColor = Color(0xFF4b68ff);
  final Color secondary = Color(0xFF60c7ff);
  final Color accent = Color(0xFFb00020);

  final Color textPrimary = Color(0xFF000000);
  final Color textSecondary = Color(0xFF757575);
  final Color textAccent = Color(0xFFFFFFFF);

  final Color gradientStart = Color(0xFF4b68ff);
  final Color gradientEnd = Color(0xFF60c7ff);

  final Color backgroundPrimary = Color(0xFFFFFFFF);
  final Color backgroundSecondary = Color(0xFFF5F5F5);

  final Color containerBackground = Color(0xFFE0E0E0);
  final Color containerShadow = Color(0xFFBDBDBD);

  final Color buttonPrimary = Color(0xFF4b68ff);
  final Color buttonSecondary = Color(0xFF60c7ff);
  final Color buttonText = Color(0xFFFFFFFF);

  final Color borderPrimary = Color(0xFF4b68ff);
  final Color borderSecondary = Color(0xFF60c7ff);

  final Color error = Color(0xFFb00020);
  final Color validation = Color(0xFF00c853);

  final Color neutralDark = Color(0xFF212121);
  final Color neutralLight = Color(0xFFFAFAFA);
}
