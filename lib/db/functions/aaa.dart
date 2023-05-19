import 'package:music_player/db/functions/db_functions.dart';
import 'package:music_player/db/models/mostplayedmodel/mostplayed.dart';

mostplaye(MostPlayed data) async {
  List<MostPlayed> list = mostplayedsongs.values.toList();

  bool already = list.where((element) => element == data).isEmpty;
  if (!already) {
    await mostplayedsongs.add(data);
  } else {
    int idx = list.indexWhere((element) => element == data);
    mostplayedsongs.put(idx, data);
  }
  int count = data.count ?? 0;
  data.count = count + 1;
  for (var item in list) {
    if (item == data) {}
  }
}
