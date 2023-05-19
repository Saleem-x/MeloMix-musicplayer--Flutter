import 'package:music_player/db/functions/db_functions.dart';
import 'package:music_player/db/models/db_model.dart';
import 'package:music_player/db/models/favoritesmodel/favoritesmodel.dart';

// addtofav(Songs song) async {
//   List<Favsongs> favsongs = favsongbox.values.toList();
//   favsongs.where((element) => element.songname == song.songname).isEmpty?addfav( )
// }

removefav(Songs song) async {
  // Favsongs temp = Favsongs(
  //     artist: song.songname,
  //     duration: song.duration,
  //     id: song.id,
  //     songname: song.songname,
  //     songurl: song.songurl);
  // favoritelistener.value
  //     .removeWhere((element) => element.songname == temp.songname);
  List<Favsongs> templist = favsongbox.values.toList();
  favsongbox.clear();
  for (int i = 0; i < templist.length; i++) {
    if (templist[i].id == song.id) {
      templist.removeAt(i);
      favsongbox.addAll(templist);
      break;
    }
  }
}
// addtofavorites(List<Favsongs >){

// } Favsongs favson = Favsongs(
            //     songname: widget.songs[widget.index].songname,
            //     artist: widget.songs[widget.index].artist,
            //     duration: widget.songs[widget.index].duration,
            //     songurl: widget.songs[widget.index].songurl,
            //     id: widget.songs[widget.index].id);

            // favsong
            //         .where((element) =>
            //             element.songname == widget.songs[widget.index].songname)
            //         .isEmpty
            //     ? add(favson)
            //     : delete(favson, context, widget.songs);