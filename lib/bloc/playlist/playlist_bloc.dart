import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:music_player/db/functions/db_functions.dart';
import 'package:music_player/db/models/playlismodel/playlistmodel.dart';

part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  PlaylistBloc() : super(PlaylistInitial(playlistbox)) {
    on<GetAllPlaylist>((event, emit) {
      emit(PlaylistState(event.playlistbox));
    });
    on<DeleteSongEvent>((event, emit) {
      // var a = playlistbox.getAt(event.plindex);
      // a!.playlistsongs!.removeAt(event.songindex);
      // playlistbox.put(event.plindex, a);
      // (index);
      emit(PlaylistState(playlistbox));
    });
  }
}
