import 'package:music_player/db/functions/db_functions.dart';
import 'package:music_player/db/models/mostplayedmodel/mostplayed.dart';
import 'package:music_player/db/models/recentmodel/recentmodel.dart';

update(RecentlyPlayed data) {
  var i = recentlyplayedbox.values.toList();

  bool isallready = false;

  isallready = i.where((element) => element == data).isEmpty;

  if (isallready == true) {
    recentlyplayedbox.add(data);
  } else {
    int index = i.indexWhere((element) => element == data);
    recentlyplayedbox.deleteAt(index);
    recentlyplayedbox.put(index, data);
  }
}

updatemostly(MostPlayed data) {
  var i = mostplayedsongs.values.toList();
  bool isallready = false;
  // int count = data.count!;
  isallready = i.where((element) => element == data).isEmpty;

  if (isallready == false) {
    mostplayedsongs.add(data);
  } else {
    int idx = i.indexWhere((element) => element == data);
    mostplayedsongs.deleteAt(idx);
    mostplayedsongs.add(data);
  }
}
