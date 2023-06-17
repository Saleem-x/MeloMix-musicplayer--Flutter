import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/bloc/allsongs/allsongs_bloc.dart';
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

class AllSongsList extends StatelessWidget {
  const AllSongsList({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return BlocBuilder<AllsongsBloc, AllsongsState>(
      builder: (context, state) {
        List<Songs> allDbSongs = state.allsongs.values.toList();
        return state.allsongs.isEmpty
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
                              IconData favicon = Icons.favorite_border;
                              return ListTile(
                                onTap: () {
                                  currentlyplaying = songs;
                                  playAudio(allDbSongs, index);
                                  updatempcount(mpsong, index);
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
                                  idx: index,
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
                            itemCount: state.allsongs.length),
                      ),
                    ],
                  ),
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
