import 'package:flutter/material.dart';

class FDialogTheme {
  FDialogTheme._();

  static DialogTheme lightDialogTheme = const DialogTheme(
    shadowColor: Colors.blue,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
  static DialogTheme darkDialogTheme = const DialogTheme(
    shadowColor: Colors.grey,
     titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}
