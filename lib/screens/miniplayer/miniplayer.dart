import 'dart:developer';
import 'package:music_player/screens/searchscreen/searchwidget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee/marquee.dart';
import 'package:music_player/db/models/db_model.dart';
import 'package:music_player/screens/commonscreens/player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../db/functions/db_functions.dart';
import '../../db/models/recentmodel/recentmodel.dart';
import '../../materials/material.dart';
import '../homescreen/homescreen.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    bool visibility = true;
    return GestureDetector(
      onDoubleTapDown: (details) {
        visibility = !visibility;
        player.stop();
      },
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.bottomToTop,
            child: const PlayerScreen(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 1.5,
                blurRadius: 5,
                offset: const Offset(0, 3),
                inset: true,
              ),
            ],
            color: sendory,
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            player.builderCurrent(
              builder: (context, playing) {
                find(player.getCurrentAudioTitle, context);
                return Row(
                  children: [
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 20,
                              decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30))),
                            ),
                            ListTile(
                              title: SizedBox(
                                height: 25,
                                width: 200,
                                child: Marquee(
                                  text: player.getCurrentAudioTitle,
                                  blankSpace: 30,
                                  style: TextStyle(
                                      color: primary,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              leading: CircleAvatar(
                                radius: 17,
                                backgroundColor: primary,
                                child: ClipOval(
                                  child: QueryArtworkWidget(
                                    id: int.parse(
                                        playing.audio.audio.metas.id!),
                                    type: ArtworkType.AUDIO,
                                    nullArtworkWidget: Image.asset(
                                        'assets/images/Retro_cassette_tape_vector-removebg-preview (2).png'),
                                  ),
                                ),
                              ),
                              trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    PlayerBuilder.isPlaying(
                                        player: player,
                                        builder: (context, isPlaying) {
                                          return Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  player.previous();
                                                  String tittle = player
                                                      .getCurrentAudioTitle;
                                                  song(tittle, context);
                                                },
                                                icon: Icon(
                                                  FontAwesomeIcons.backward,
                                                  color: primary,
                                                  size: 20,
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () async {
                                                    isPlaying =
                                                        isPlaying = !isPlaying;
                                                    await player.playOrPause();
                                                  },
                                                  icon: Icon(
                                                    isPlaying
                                                        ? FontAwesomeIcons
                                                            .circlePause
                                                        : FontAwesomeIcons
                                                            .circlePlay,
                                                    color: primary,
                                                    size: 25,
                                                  )),
                                              IconButton(
                                                onPressed: () {
                                                  player.next();
                                                  String tittle = player
                                                      .getCurrentAudioTitle;
                                                  song(tittle, context);
                                                },
                                                icon: Icon(
                                                  FontAwesomeIcons.forward,
                                                  color: primary,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ]),
                            )
                          ]),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

song(String title, BuildContext context) {
  for (Songs song in listall) {
    if (song.songname == title) {
      updaterecentlyplayed(addtorec(song), context);
      log(song.songname!);
    }
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

find(String title, BuildContext context) {
  for (var song in listall) {
    if (song.songname == title) {
      updaterecentlyplayed(
          RecentlyPlayed(
              id: song.id,
              songname: song.songname,
              artist: song.artist,
              songurl: song.songurl,
              duration: song.duration),
          context);
    }
  }
}
