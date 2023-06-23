import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/bloc/theme/theme_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Color primary = const Color.fromRGBO(146, 114, 221, 1.0);
// Color sendory = const Color.fromRGBO(211, 227, 242, 1.0);

Color primary = const Color.fromRGBO(146, 114, 221, 1.0);
Color sendory = const Color.fromRGBO(211, 227, 242, 1.0);

bool dark = false;
themeswitcher(bool isdark, BuildContext context) async {
  final sharedprefs = await SharedPreferences.getInstance();

  if (isdark == true) {
    primary = const Color.fromRGBO(146, 114, 221, 1.0);
    sendory = const Color.fromRGBO(211, 227, 242, 1.0);
    sharedprefs.setInt('color1', primary.value);
    sharedprefs.setInt('color2', primary.value);
    // ignore: use_build_context_synchronously
    BlocProvider.of<ThemeBloc>(context).add(DarkTheme(primary, sendory, false));
  } else {
    primary = const Color.fromRGBO(72, 72, 72, 1.0);
    sendory = const Color.fromRGBO(40, 40, 40, 1.0);
    sharedprefs.setInt('color1', primary.value);
    sharedprefs.setInt('color2', primary.value);
    // ignore: use_build_context_synchronously
    BlocProvider.of<ThemeBloc>(context).add(DarkTheme(primary, sendory, true));
  }
}
