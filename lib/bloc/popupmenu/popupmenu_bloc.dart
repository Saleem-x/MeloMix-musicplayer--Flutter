import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:music_player/db/functions/db_functions.dart';
import 'package:music_player/db/models/favoritesmodel/favoritesmodel.dart';
part 'popupmenu_event.dart';
part 'popupmenu_state.dart';

class PopupmenuBloc extends Bloc<PopupmenuEvent, PopupmenuState> {
  PopupmenuBloc() : super(PopupmenuInitial(favsongbox)) {
    on<AddtoFavEvent>((event, emit) {
      emit(PopupmenuState(event.favoritesongs));
    });
    on<AddfavEvent>((event, emit) async {
      await favsongbox.add(event.favsong);
    });
    on<RemoveFavEvent>((event, emit) async {
      int currentidx = favsongbox.values
          .toList()
          .indexWhere((element) => element.id == event.favsong.id);
      await favsongbox.deleteAt(currentidx);
    });
  }
}
