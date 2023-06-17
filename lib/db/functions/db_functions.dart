import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:music_player/bloc/playlist/playlist_bloc.dart';
import 'package:music_player/bloc/recent/recentscreen_bloc.dart';
import 'package:music_player/db/models/favoritesmodel/favoritesmodel.dart';
import 'package:music_player/db/models/mostplayedmodel/mostplayed.dart';
import 'package:music_player/db/models/playlismodel/playlistmodel.dart';
import '../models/recentmodel/recentmodel.dart';

late Box<RecentlyPlayed> recentlyplayedbox;
openrecentlyplayeddb() async {
  recentlyplayedbox = await Hive.openBox("recentlyplayed");
}

// late Box<AllSongs> allsongdb;
// openallsongdb() async {
//   allsongdb=await Hive.openBox('')
// }

late Box<Playlistsongs> playlistbox;
openplaylistdb() async {
  playlistbox = await Hive.openBox<Playlistsongs>('playlist');
}

late Box<Favsongs> favsongbox;
openfavdb() async {
  favsongbox = await Hive.openBox('favdb');
}

updaterecentlyplayed(RecentlyPlayed value, BuildContext context) {
  List<RecentlyPlayed> list = recentlyplayedbox.values.toList();
  bool isallready =
      list.where((element) => element.songname == value.songname).isEmpty;
  if (isallready == true) {
    recentlyplayedbox.add(value);
  } else {
    int index =
        list.indexWhere((element) => element.songname == value.songname);
    recentlyplayedbox.deleteAt(index);
    recentlyplayedbox.add(value);
  }
  BlocProvider.of<RecentscreenBloc>(context)
      .add(UpdateRecentEvent(recentbox: recentlyplayedbox));
}

late Box<MostPlayed> mostplayedsongs;
openmostpllayeddb() async {
  mostplayedsongs = await Hive.openBox('mostplayeddb');
}

updatempcount(MostPlayed data, int index) async {
  List<MostPlayed> templist = mostplayedsongs.values.toList();
  bool isallready =
      templist.where((element) => element.songname == data.songname).isEmpty;
  if (isallready == true) {
    await mostplayedsongs.add(data);
  } else {
    int index =
        templist.indexWhere((element) => element.songname == data.songname);
    await mostplayedsongs.deleteAt(index);
    await mostplayedsongs.put(index, data);
  }
  int count = data.count ?? 0;
  data.count = count + 1;
}

renameplaylist(int index, String newname, BuildContext context) async {
  var playlists = playlistbox.values.toList();
  playlists[index].playlistname = newname;
  playlistbox.putAt(index, playlists[index]);
  BlocProvider.of<PlaylistBloc>(context)
      .add(GetAllPlaylist(playlistbox: playlistbox));
}
