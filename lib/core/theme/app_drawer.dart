import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppDrawerThemes {
  AppDrawerThemes._();

  static const lightAppDrawerThemes = DrawerThemeData(
    elevation: 0,
    backgroundColor: Colors.blue,
    surfaceTintColor: Colors.transparent,
    DrawerHeaderColor: Colors.blue,
    
    
  );

  static const darkAppDrawerThemes = DrawerThemeData(
    elevation: 0,
    backgroundColor: Colors.blueGrey,
    surfaceTintColor: Colors.s.transparent,
    DrawerHeaderColor: Colors.blue,
  );
}

class DrawerHeaderColor {
}
