import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/bloc/playlist/playlist_bloc.dart';
import 'package:music_player/db/functions/db_functions.dart';

deletesong(int index, int plindex, BuildContext context) {
  var a = playlistbox.getAt(plindex);
  a!.playlistsongs!.removeAt(index);
  // playlistbox.put(plindex, a);
  // (index);
  BlocProvider.of<PlaylistBloc>(context)
      .add(GetAllPlaylist(playlistbox: playlistbox));
}
