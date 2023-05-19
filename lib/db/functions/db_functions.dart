import 'package:hive/hive.dart';
import 'package:music_player/db/models/favoritesmodel/favoritesmodel.dart';
import 'package:music_player/db/models/mostplayedmodel/mostplayed.dart';
import 'package:music_player/db/models/playlismodel/playlistmodel.dart';
import 'package:music_player/screens/mostplayed/mostlyplayed.dart';
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

// addtoplaylist(Songs song, String playlistname) async {
//   Box<Playlistsongs> playlist = await Hive.openBox('playlist');
//   for (Playlistsongs element in playlist.values) {
//     if (element.playlistname == playlistname) {
//       var key = element.key;
//       // Playlistsongs updatepplaylist.add
//     }
//   }
// }
late Box<MostPlayed> mostplayedsongs;
openmostpllayeddb() async {
  mostplayedsongs = await Hive.openBox('mostplayeddb');
}

updatemostplayedcount(MostPlayed data, int index) async {
  // int count = data.count!;
  // data.count = count + 1;
  // // await mostplayedsongs.delete(data);
  // await mostplayedsongs.put(0, data);
  // allmpsongs.add(data);
  // // allmpsongs.clear();
  // allmpsongs.addAll(mostplayedsongs.values);
  // updatemostplayed();
  await mostplayedsongs.put(index, data);
  allmpsongs.add(data);
}

updatemostplayed(MostPlayed data) {
  // int index;
  // List<MostPlayed> mpsongs = allmpsongs.toList();
  // int count = data.count!;
  // data.count = count + 1;
  // if (mpsongs.contains(data)) {
  //   index = mpsongs.indexWhere((element) => element.id == data.id);
  //   // mostplayedsongs.deleteAt(index);
  //   mostplayedsongs.put(index, data);
  // } else {
  //   mostplayedsongs.add(data);
  // }
  // int count = data.count!;
  data.count = data.count! + 1;
  List<MostPlayed> mpsongs = mostplayedsongs.values.toList();
  bool isalready = mpsongs.where((element) => element.id == data.id).isEmpty;
  if (isalready == true) {
    int index = mpsongs.indexWhere((element) => element == data);
    // data.count = data.count! + 1;
    mostplayedsongs.deleteAt(index);
    mostplayedsongs.put(index, data);
  } else {
    mostplayedsongs.add(data);
  }
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
  String currentname = playlists[index].playlistname;
  playlists[index].playlistname = newname;
  playlistbox.put(index, playlists[index]);
}
// addtorecauto() {
//   String title;
//   if (player.isPlaying == true) {
//     title = player.getCurrentAudioTitle;
//     for (Songs song in listall) {
//       if (song.songname == title) {
//         addtorec(song);
//       }
//     }
//   }
// }

// addfav(Favsongs favson, context) async {
//   await favsongbox.add(favson);
//   favoritelistener.value.add(favson);
//   ScaffoldMessenger.of(context)
//     ..removeCurrentSnackBar()
//     ..showSnackBar(SnackBar(
//       backgroundColor: sendory,
//       content: Row(
//         children: [
//           Text(
//             'Song Added to Favorites',
//             style: TextStyle(
//                 color: primary, fontSize: 17, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//           Icon(
//             Icons.info,
//             color: primary,
//           )
//         ],
//       ),
//     ));
// }

// deletefav(Favsongs favson, BuildContext context, songlist, index) async {
//   int currentidx =
//       favsongbox.indexWhere((element) => element.id == songlist[index].id);
//   await favsongbox.deleteAt(currentidx);
//   favoritelistener.value.remove(favson);
//   ScaffoldMessenger.of(context)
//     ..removeCurrentSnackBar()
//     ..showSnackBar(
//       SnackBar(
//         backgroundColor: sendory,
//         content: Row(
//           children: [
//             Text(
//               'Song Removed from Favorites',
//               style: TextStyle(
//                   color: primary, fontSize: 17, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//             Icon(
//               Icons.info,
//               color: primary,
//             )
//           ],
//         ),
//       ),
//     );
// }

// playlistadd(List<Songs> plnewsongs, List<Songs> songs, int index,
//     BuildContext context) {
//   bool contains = false;
//   for (var item in plnewsongs) {
//     if (songs[index].songname == item.songname) {
//       contains = true;
//       break;
//     } else {
//       contains = false;
//     }
//   }
//   if (contains == false) {
//     plnewsongs.add(Songs(
//         songname: songs[index].songname,
//         artist: songs[index].artist,
//         duration: songs[index].duration,
//         id: songs[index].duration,
//         songurl: songs[index].songurl));
//     ScaffoldMessenger.of(context)
//       ..removeCurrentSnackBar()
//       ..showSnackBar(
//         SnackBar(
//           backgroundColor: sendory,
//           content: Row(
//             children: [
//               Text(
//                 'Song added to Playlist',
//                 style: TextStyle(
//                     color: primary, fontSize: 17, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Icon(
//                 Icons.info,
//                 color: primary,
//               )
//             ],
//           ),
//         ),
//       );
//     Navigator.pop(context);
//   } else {
//     ScaffoldMessenger.of(context)
//       ..removeCurrentSnackBar()
//       ..showSnackBar(
//         SnackBar(
//           backgroundColor: sendory,
//           content: Row(
//             children: [
//               Text(
//                 'Song  already in Playlist',
//                 style: TextStyle(
//                     color: primary, fontSize: 17, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Icon(
//                 Icons.info,
//                 color: primary,
//               )
//             ],
//           ),
//         ),
//       );
//     Navigator.pop(context);
//   }
// }



//  mostplayedfetch() async {
//     Box<int> mostplayedDb = await Hive.openBox('mostplayed');
//     if (mostplayedDb.isEmpty) {
//       for (Songs song in listall) {
//         mostplayedDb.put(song.id, 0);
//       }
//     } else {
//       List<List<int>> mostplayedTemp = [];
//       for (Songs song in listall) {
//         int count = mostplayedDb.get(song.id)!;
//         mostplayedTemp.add([song.id!, count]);
//       }
//       for (int i = 0; i < mostplayedTemp.length - 1; i++) {
//         for (int j = i; j < mostplayedTemp.length; j++) {
//           if (mostplayedTemp[i][1] < mostplayedTemp[j][1]) {
//             List<int> temp = mostplayedTemp[i];
//             mostplayedTemp[i] = mostplayedTemp[j];
//             mostplayedTemp[j] = temp;
//           }
//         }
//       }

//       List<List<int>> temp = [];
//       for (int i = 0; i < mostplayedTemp.length && i < 10; i++) {
//         temp.add(mostplayedTemp[i]);
//       }

//       mostplayedTemp = temp;
//       for (List<int> element in mostplayedTemp) {
//         for (Songs song in listall) {
//           if (element[0] == song.id && element[1] > 3) {
//             mostplayedsongs.add(MostPlayed(songname: song.songname!, artist:song.artist!, duration: song.duration!, songurl:song. songurl!, count:, id: song.id!));
//           }
//         }
//       }
//     }
//   }