part of 'playlist_bloc.dart';

@immutable
abstract class PlaylistEvent {}

class GetAllPlaylist extends PlaylistEvent {
  final Box<Playlistsongs> playlistbox;

  GetAllPlaylist({required this.playlistbox});
}

class DeleteSongEvent extends PlaylistEvent {
  final Playlistsongs playlist;
  final int plindex;
  final int songindex;

  DeleteSongEvent(
      {required this.playlist, required this.plindex, required this.songindex});
}
