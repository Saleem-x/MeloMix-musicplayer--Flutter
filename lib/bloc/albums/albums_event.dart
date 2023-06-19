part of 'albums_bloc.dart';

@immutable
abstract class AlbumsEvent {}

class FetchAlbumsEvent extends AlbumsEvent {
  final List<AlbumModel> albumslist;

  FetchAlbumsEvent(this.albumslist);
}

class FetchAlbumSongEvent extends AlbumsEvent {
  final List<SongModel> albumsongs;
  FetchAlbumSongEvent({required this.albumsongs});
}
