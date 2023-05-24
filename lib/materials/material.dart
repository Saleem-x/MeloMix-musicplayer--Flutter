import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Color primary = const Color.fromRGBO(146, 114, 221, 1.0);
// Color sendory = const Color.fromRGBO(211, 227, 242, 1.0);

Color primary = const Color.fromRGBO(146, 114, 221, 1.0);
Color sendory = const Color.fromRGBO(211, 227, 242, 1.0);

bool dark = false;
themeswitcher(bool isdark) async {
  final sharedprefs = await SharedPreferences.getInstance();

  if (isdark == true) {
    primary = const Color.fromRGBO(146, 114, 221, 1.0);
    sendory = const Color.fromRGBO(211, 227, 242, 1.0);
    sharedprefs.setInt('color1', primary.value);
    sharedprefs.setInt('color2', primary.value);
  } else {
    primary = const Color.fromRGBO(72, 72, 72, 1.0);
    sendory = const Color.fromRGBO(40, 40, 40, 1.0);
    sharedprefs.setInt('color1', primary.value);
    sharedprefs.setInt('color2', primary.value);
  }
}
