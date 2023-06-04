import 'package:hive/hive.dart';
import 'package:music_player/db/models/favoritesmodel/favoritesmodel.dart';
import 'package:music_player/db/models/mostplayedmodel/mostplayed.dart';
import 'package:music_player/db/models/playlismodel/playlistmodel.dart';
import '../models/recentmodel/recentmodel.dart';

late Box<RecentlyPlayed> recentlyplayedbox;
openrecentlyplayeddb() async {
  recentlyplayedbox = await Hive.openBox("recentlyplayed");
}

late Box<Playlistsongs> playlistbox;
openplaylistdb() async {
  playlistbox = await Hive.openBox<Playlistsongs>('playlist');
}

late Box<Favsongs> favsongbox;
openfavdb() async {
  favsongbox = await Hive.openBox('favdb');
}

updaterecentlyplayed(RecentlyPlayed value) {
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

renameplaylist(int index, String newname) {
  var playlists = playlistbox.values.toList();
  playlists[index].playlistname = newname;
  playlistbox.put(index, playlists[index]);
}
