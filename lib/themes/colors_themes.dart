import 'package:flutter/material.dart';

class ColorsThemes {
  static const MaterialColor _colorPrimarySwatch = MaterialColor(
    0xff3F3FFE,
    <int, Color>{
      50: Color(0xff3F3FFE),
      100: Color(0xff3F3FFE),
      200: Color(0xff3F3FFE),
      300: Color(0xff3F3FFE),
      400: Color(0xff3F3FFE),
      500: Color(0xff3F3FFE),
      600: Color(0xff3F3FFE),
      700: Color(0xff3F3FFE),
      800: Color(0xff3F3FFE),
      900: Color(0xff3F3FFE),
    },
  );

  static final lightTheme = ThemeData(
    primarySwatch: _colorPrimarySwatch,
  );
}
