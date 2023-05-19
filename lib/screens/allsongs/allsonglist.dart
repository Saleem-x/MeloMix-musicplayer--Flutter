import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/functions/db_functions.dart';
import 'package:music_player/db/functions/playerfunctions.dart';
import 'package:music_player/db/models/db_model.dart';
import 'package:music_player/db/models/mostplayedmodel/mostplayed.dart';
import 'package:music_player/db/models/recentmodel/recentmodel.dart';
import 'package:music_player/screens/commonscreens/popupmenu.dart';
import 'package:music_player/screens/mostplayed/mostlyplayed.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../materials/material.dart';
import '../homescreen/homescreen.dart';
import '../searchscreen/searchwidget.dart';

// import 'package:audioplayers/audioplayers.dart';

// ignore: must_be_immutable
class AllSongsList extends StatefulWidget {
  const AllSongsList({
    super.key,
  });

  @override
  State<AllSongsList> createState() => _AllSongsListState();
}

class _AllSongsListState extends State<AllSongsList> {
  bool? isplaying;
  IconData? playicon;
  final box = SongBox.getInstance();
  List<Audio> convertAudio = [];

  Duration dur = const Duration();
  Duration pos = const Duration();

  @override
  void initState() {
    List<Songs> dbsongs = box.values.toList();
    for (var item in dbsongs) {
      convertAudio.add(
        Audio.file(
          item.songurl!,
          metas: Metas(
            title: item.songname,
            artist: item.artist,
            id: item.id.toString(),
          ),
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    // final double width = MediaQuery.of(context).size.width;
    return ValueListenableBuilder<Box<Songs>>(
      valueListenable: box.listenable(),
      builder: (context, Box<Songs> allsongbox, child) {
        List<Songs> allDbSongs = allsongbox.values.toList();
        // List<MostPlayed> mostplayed = mostplayedsongs.values.toList();
        return allDbSongs.isEmpty
            ? songlistempty()
            : Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              Songs songs = allDbSongs[index];
                              MostPlayed mpsong = allmpsongs[index];
                              // MostPlayed mpsongs = [index];
                              IconData favicon = Icons.favorite_border;
                              return ListTile(
                                onTap: () {
                                  currentlyplaying = songs;
                                  playAudio(allDbSongs, index);
                                  RecentlyPlayed rsongs;
                                  rsongs = addtorec(songs);
                                  updatempcount(mpsong, index);
                                  // log(songs.id.toString());
                                },
                                title: Text(
                                  songs.songname!,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.play(
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: SingleChildScrollView(
                                  child: Text(
                                    songs.artist!
                                        .toUpperCase()
                                        .toLowerCase()
                                        .replaceAll('?', ''),
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.play(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: sendory,
                                  child: ClipOval(
                                    child: QueryArtworkWidget(
                                      id: songs.id!,
                                      type: ArtworkType.AUDIO,
                                      nullArtworkWidget: Image.asset(
                                          'assets/images/Retro_cassette_tape_vector-removebg-preview (2).png'),
                                    ),
                                  ),
                                ),
                                trailing: Popupmenu(
                                  favicon: favicon,
                                  height: height,
                                  index: index,
                                  songs: listall,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                thickness: 1,
                                color: sendory,
                                endIndent: 20,
                                indent: 20,
                                height: 0,
                              );
                            },
                            itemCount: allDbSongs.length),
                      ),
                    ],
                  ),
                  // currentlyplaying != null
                  //     ? const Padding(
                  //         padding:
                  //             EdgeInsets.only(bottom: 10, right: 10, left: 10),
                  //         child: Align(
                  //           alignment: Alignment.bottomRight,
                  //           child: SizedBox(
                  //             height: 100,
                  //             width: double.infinity,
                  //             child: MiniPlayer(),
                  //           ),
                  //         ),
                  //       )
                  //     : const Padding(
                  //         padding: EdgeInsetsDirectional.all(10),
                  //         child: Align(
                  //           alignment: Alignment.bottomCenter,
                  //           child: MiniPlayerNull(),
                  //         ),
                  //       )
                ],
              );
      },
    );
  }

  RecentlyPlayed addtorec(Songs songs) {
    return RecentlyPlayed(
        id: songs.id,
        songname: songs.songname,
        artist: songs.artist,
        songurl: songs.songurl,
        duration: songs.duration);
  }

  playerontap() {}

  songlistempty() {
    return const Center(
      child: Text(
        'No songs found (Check permission)',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
