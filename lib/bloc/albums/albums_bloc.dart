import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'albums_event.dart';
part 'albums_state.dart';

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  AlbumsBloc() : super(AlbumsInitial(null)) {
    on<FetchAlbumsEvent>((event, emit) {
      emit(AlbumsState(event.albumslist));
    });
    on<FetchAlbumSongEvent>((event, emit) {
      emit(AlbumSongState(albumsongs: event.albumsongs));
    });
  }
}
