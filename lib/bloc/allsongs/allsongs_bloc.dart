import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:music_player/db/models/db_model.dart';
import 'package:music_player/screens/splashscreen.dart';

part 'allsongs_event.dart';
part 'allsongs_state.dart';

class AllsongsBloc extends Bloc<AllsongsEvent, AllsongsState> {
  AllsongsBloc() : super(AllsongsInitial(box)) {
    on<GetAllSongs>((event, emit) {
      emit(AllsongsState(event.allsongs));
    });
  }
}
