import 'package:flutter/material.dart';

class LightTheme {
  // Color primary = const Color.fromRGBO(146, 114, 221, 1.0);
  // Color sendory = const Color.fromRGBO(211, 227, 242, 1.0);
}

class DarkTheme {
  Color primary = const Color.fromRGBO(72, 72, 72, 1.0);
  Color sendory = const Color.fromRGBO(40, 40, 40, 1.0);
}

ThemeData light = LightTheme() as ThemeData;
ThemeData dark = DarkTheme() as ThemeData;
