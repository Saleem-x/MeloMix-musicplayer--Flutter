part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

// class SwitchTheme extends ThemeEvent {
//   final Color primary;
//   final Color sencondary;

//   SwitchTheme(this.primary, this.sencondary);
// }

class DarkTheme extends ThemeEvent {
  final Color primary;
  final Color sencondary;
  final bool isDark;

  DarkTheme(this.primary, this.sencondary, this.isDark);
}
