import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_player/materials/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial(primary, sendory, false)) {
    on<DarkTheme>((event, emit) {
      emit(ThemeState(event.primary, event.sencondary, event.isDark));
    });
  }
}
