import 'package:flutter/material.dart';
import 'package:movies_app/core/colors_manager.dart';

class MyTheme {
  static ThemeData theme = ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(color: Colors.yellow),
        unselectedIconTheme: IconThemeData(color: Colors.white),
        backgroundColor: ColorsManager.bottomNavigationBarBg,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white),
  );
}
