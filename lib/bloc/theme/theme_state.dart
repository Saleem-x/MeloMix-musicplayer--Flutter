part of 'theme_bloc.dart';

class ThemeState {
  final Color primary;
  final Color sencondary;
  final bool isDark;
  ThemeState(this.primary, this.sencondary, this.isDark);
}

class ThemeInitial extends ThemeState {
  ThemeInitial(super.primary, super.sencondary, super.isDark);
}
