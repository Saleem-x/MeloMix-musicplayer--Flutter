import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:music_player/db/functions/db_functions.dart';
import 'package:music_player/db/models/favoritesmodel/favoritesmodel.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial(favsongbox)) {
    on<FavoriteSongsListEvent>((event, emit) {
      emit(FavoriteState(event.favsongbox));
    });
  }
}
