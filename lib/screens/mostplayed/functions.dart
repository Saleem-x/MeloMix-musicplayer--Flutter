import 'package:music_player/db/models/db_model.dart';
import 'package:music_player/db/models/mostplayedmodel/mostplayed.dart';

import '../../db/functions/db_functions.dart';

List<MostPlayed> addtolist() {
  List<MostPlayed> mostPlayedList = [];
  for (var item in mostplayedsongs.values) {
    if (item.count! > 4) {
      mostPlayedList = mostplayedsongs.values.toList();
    }
  }
  mostPlayedList.sort((a, b) => a.count!.compareTo(b.count!));
  mostPlayedList = mostPlayedList.reversed.toList();
  List<MostPlayed> templist = [];
  for (var item in mostPlayedList) {
    if (item.count! > 4) {
      templist.add(item);
    }
  }
  return templist;
}

converttolist(List<MostPlayed> tolist, List<Songs> favl) {
  for (var item in tolist) {
    favl.add(Songs(
        songname: item.songname,
        artist: item.artist,
        duration: item.duration,
        id: item.id,
        songurl: item.songurl));
  }
  return favl;
}
