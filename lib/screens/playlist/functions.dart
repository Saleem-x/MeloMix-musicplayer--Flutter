import 'package:music_player/db/functions/db_functions.dart';

deletesong(int index, int plindex) {
  var a = playlistbox.getAt(plindex);
  a!.playlistsongs!.removeAt(index);
  playlistbox.put(plindex, a);
  (index);
  playlistbox.put(plindex, a);
}
