import 'package:flutter/material.dart';

class FBottomsheetThemes {
  FBottomsheetThemes._();
  static BottomSheetThemeData lightBottomSheetTheme = const BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: Colors.blue,
    modalBackgroundColor: Colors.white,
    constraints: BoxConstraints(minWidth: double.infinity),
  );
  static BottomSheetThemeData darkBottomSheetTheme = const BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: Colors.blue,
    modalBackgroundColor: Colors.white,
    constraints: BoxConstraints(minWidth: double.infinity),
  );
}

