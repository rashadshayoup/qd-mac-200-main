import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

const Color _kprimaryColor = Color(0xFF54a0ff);
// const Color _kprimaryColor = Color(0xFF801b49);
// const Color _kprimaryColor = Color(0xFF6F35A5); //مووف

// const Color _kprimaryColor = Color.fromARGB(255, 96, 55, 134);
class Themes {
  static final showSnackBarColor = _kprimaryColor;
  //dark color
  static final dark_white = Colors.white;
  static final dark_primary2 = Color(0xFF424242);
  static final dark_primary = Color.fromARGB(255, 48, 47, 47);
  static final dark_grey = Colors.grey;

  // light
  static final light_white = Colors.white;
  static final light_grey = Colors.grey;
  static final light_black = Colors.black;
  static final light_primary = Colors.grey[350];
  // static final discount = Color(0xFFf44236);
  static final discount = Color.fromARGB(255, 206, 60, 50);
  static final add = Color(0xFF4cb050);

  static final light = ThemeData(
      textTheme: TextTheme(titleMedium: TextStyle(color: _kprimaryColor)),
      primaryColor: _kprimaryColor,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.grey[350]);
  static final dark = ThemeData(
    primaryColor: Colors.red,
    brightness: Brightness.dark,
  );
}
