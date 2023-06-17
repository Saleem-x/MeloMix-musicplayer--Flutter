part of 'playlist_bloc.dart';

class PlaylistState {
  final Box<Playlistsongs> playlistbox;
  PlaylistState(this.playlistbox);
}

class PlaylistInitial extends PlaylistState {
  PlaylistInitial(super.playlistbox);
}
