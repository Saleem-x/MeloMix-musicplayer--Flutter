part of 'albums_bloc.dart';

class AlbumsState {
  final List<AlbumModel>? albumslist;

  AlbumsState(this.albumslist);
}

class AlbumSongState extends AlbumsState {
  final List<SongModel> albumsongs;
  AlbumSongState(this.albumsongs) : super([]);
}

class AlbumsInitial extends AlbumsState {
  AlbumsInitial(super.albumslist);
}
