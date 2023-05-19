import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/db/functions/db_functions.dart';
import 'package:music_player/db/models/recentmodel/recentmodel.dart';
import 'package:music_player/screens/commonscreens/popupmenu.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../db/functions/playerfunctions.dart';
import '../../db/models/db_model.dart';
import '../../materials/material.dart';
import '../searchscreen/searchwidget.dart';

List<Songs> recentList = [];

// ignore: must_be_immutable
class RecentList extends StatelessWidget {
  const RecentList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    // final double width = MediaQuery.of(context).size.width;
    return ValueListenableBuilder(
      valueListenable: recentlyplayedbox.listenable(),
      builder: (context, recentsongs, child) {
        // print('hhhhh');
        List<RecentlyPlayed> rsongs =
            recentsongs.values.toList().reversed.toList();
        List<Songs> topopup = [];
        for (int i = 0; i < rsongs.length; i++) {
          topopup.add(Songs(
              songname: rsongs[i].songname,
              artist: rsongs[i].artist,
              duration: rsongs[i].duration,
              id: rsongs[i].id,
              songurl: rsongs[i].songurl));
        }
        return rsongs.isEmpty
            ? recentempty()
            : ListView.separated(
                // physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (
                  context,
                  index,
                ) {
                  return ListTile(
                    onTap: () {
                      Songs selectedsong = Songs(
                          songname: rsongs[index].songname,
                          artist: rsongs[index].artist,
                          duration: rsongs[index].duration,
                          id: rsongs[index].id,
                          songurl: rsongs[index].songurl);
                      int songindex = 0;
                      for (int i = 0; i < listall.length; i++) {
                        if (selectedsong.id == listall[i].id) {
                          songindex = i;
                        }
                      }
                      playAudio(listall, songindex);
                      updaterecentlyplayed(rsongs[index]);
                      log(rsongs[0].songname.toString());
                    },
                    title: Text(
                      rsongs[index].songname!,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.play(
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      rsongs[index].artist!,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.play(
                        color: Colors.white,
                      ),
                    ),
                    leading: CircleAvatar(
                        backgroundColor: sendory,
                        child: QueryArtworkWidget(
                          id: rsongs[index].id!,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: Image.asset(
                              'assets/images/Retro_cassette_tape_vector-removebg-preview (2).png'),
                        )),
                    trailing: Popupmenu(
                      favicon: Icons.favorite_border,
                      height: height,
                      index: index,
                      songs: topopup,
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
                itemCount: rsongs.length >= 10 ? 10 : rsongs.length);
      },
    );
  }
}

RecentlyPlayed addtorec(Songs songs) {
  return RecentlyPlayed(
      id: songs.id,
      songname: songs.songname,
      artist: songs.artist,
      songurl: songs.songurl,
      duration: songs.duration);
}

recentempty() {
  return Center(
    child: ListView(
      children: [
        SizedBox(
          height: 250,
          width: 100,
          child: Lottie.asset('assets/search-not-found.json'),
        ),
        Center(
          child: Text(
            'Play Some Songs',
            style: TextStyle(
                color: sendory, fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
      ],
    ),
  );
}
