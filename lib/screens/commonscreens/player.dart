import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genius_lyrics/genius_lyrics.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:music_player/db/functions/db_functions.dart';
import 'package:music_player/db/models/db_model.dart';
import 'package:music_player/db/models/favoritesmodel/favoritesmodel.dart';
import 'package:music_player/screens/commonscreens/lyricbottomsheet.dart';
import 'package:music_player/screens/miniplayer/miniplayer.dart';
import 'package:music_player/screens/searchscreen/searchwidget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../materials/material.dart';
import '../favorites/favoriteslist.dart';
import '../homescreen/homescreen.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

import 'functions.dart';

Favsongs? tofav;

List<Favsongs> favsong = [];

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

// final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    var loop = false;

    // Color repeatcolor = sendory;
    Duration duration = Duration.zero;
    Duration position = Duration.zero;
    return SafeArea(
        child: Scaffold(
      backgroundColor: sendory,
      body: SafeArea(
        child: PlayerBuilder.current(
          player: player,
          builder: (context, playing) {
            IconData favicon = Icons.favorite_border;
            favsong
                    .where((element) =>
                        element.songname == player.getCurrentAudioTitle)
                    .isEmpty
                ? favicon = Icons.favorite_border
                : favicon = Icons.favorite;
            find(player.getCurrentAudioTitle);
            return Stack(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            FontAwesomeIcons.chevronLeft,
                            color: primary,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                            ),
                          ),
                          height: height * 0.05,
                          width: width * 0.8,
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              'Currently Playing',
                              style: GoogleFonts.play(
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60),
                          ),
                        ),
                        child: Column(children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                'From',
                                style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text('Library',
                                  style: TextStyle(
                                      letterSpacing: 1.5,
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          const SizedBox(
                            height: 60,
                          ),

                          CircleAvatar(
                            backgroundColor: sendory,
                            radius: 90,
                            child: ClipOval(
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(90),
                                child: QueryArtworkWidget(
                                  id: int.parse(playing.audio.audio.metas.id!),
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget: Image.asset(
                                    'assets/images/Retro_cassette_tape_vector-removebg-preview (2).png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  tooltip: 'Lyrics',
                                  onPressed: () async {
                                    String title = player.getCurrentAudioTitle;
                                    String artist =
                                        player.getCurrentAudioArtist;
                                    ScaffoldMessenger.of(context)
                                      ..removeCurrentSnackBar()
                                      ..showSnackBar(SnackBar(
                                        backgroundColor: sendory,
                                        content: Row(
                                          children: [
                                            Text(
                                              'generating Lyrics please wait',
                                              style: GoogleFonts.play(
                                                  color: primary, fontSize: 17),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.info,
                                              color: primary,
                                            )
                                          ],
                                        ),
                                      ));
                                    String? lyric;
                                    setState(() {});
                                    Song? song = (await genius.searchSong(
                                        artist: title, title: artist));
                                    if (song != null) {
                                      // print(song.lyrics);
                                      log(song.lyrics.toString());
                                      lyric = song.lyrics;
                                    }
                                    if (lyric != null) {
                                      // ignore: use_build_context_synchronously
                                      // await Navigator.push(context,
                                      //     MaterialPageRoute(
                                      //   builder: (context) {
                                      //     return LyricsScreen(
                                      //       artist: artist,
                                      //       songname: title,
                                      //       lyrics: lyric ??
                                      //           'No Lyrics available for this song',
                                      //     );
                                      //   },
                                      // ));
                                      // ignore: use_build_context_synchronously
                                      showlirics(context, lyric);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                        ..removeCurrentSnackBar()
                                        ..showSnackBar(SnackBar(
                                          backgroundColor: sendory,
                                          content: Row(
                                            children: [
                                              Text(
                                                'Lyrics Not Available',
                                                style: GoogleFonts.play(
                                                    color: primary,
                                                    fontSize: 17),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.info,
                                                color: primary,
                                              )
                                            ],
                                          ),
                                        ));
                                    }
                                  },
                                  icon: const Icon(
                                    FontAwesomeIcons.chartBar,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 80,
                              right: 80,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Text(
                                //   player.getCurrentAudioTitle,
                                //   overflow: TextOverflow.ellipsis,
                                //   style: const TextStyle(
                                //       color: Colors.white,
                                //       fontSize: 17,
                                //       fontWeight: FontWeight.bold),
                                // ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 200,
                                      child: Marquee(
                                        text: player.getCurrentAudioTitle,
                                        blankSpace: 30,
                                        style: GoogleFonts.play(
                                          fontSize: 17,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  player.getCurrentAudioArtist,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.play(
                                      color: Colors.grey.shade400,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          PlayerBuilder.realtimePlayingInfos(
                              player: player,
                              builder: (context, realtimePlayingInfos) {
                                duration = realtimePlayingInfos
                                    .current!.audio.duration;
                                position = realtimePlayingInfos.currentPosition;

                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40),
                                  child: ProgressBar(
                                    timeLabelTextStyle:
                                        TextStyle(color: sendory),
                                    baseBarColor: Colors.grey,
                                    progressBarColor: sendory,
                                    thumbColor: sendory,
                                    progress: position,
                                    timeLabelPadding: 10,
                                    total: duration,
                                    onSeek: (duration) async {
                                      await player.seek(duration);
                                    },
                                  ),
                                );
                              }),
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25, right: 25, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        // int recIndex = listall.indexWhere(
                                        //     (element) =>
                                        //         element.id.toString() ==
                                        //         player.id);
                                        // final recValue =
                                        //     addtorec(listall[recIndex - 1]);
                                        // updaterecentlyplayed(recValue);
                                        player.previous();
                                        String tittle =
                                            player.getCurrentAudioTitle;
                                        song(tittle);
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.backward,
                                        color: Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await player.seekBy(
                                            const Duration(seconds: -10));
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.arrowRotateLeft,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                    PlayerBuilder.isPlaying(
                                      player: player,
                                      builder: (context, isPlaying) {
                                        return IconButton(
                                            onPressed: () async {
                                              isPlaying =
                                                  isPlaying = !isPlaying;
                                              await player.playOrPause();
                                            },
                                            icon: Icon(
                                              isPlaying
                                                  ? FontAwesomeIcons.circlePause
                                                  : FontAwesomeIcons.circlePlay,
                                              color: sendory,
                                              size: 30,
                                            ));
                                      },
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await player.seekBy(
                                            const Duration(seconds: 10));
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.arrowRotateRight,
                                        color: Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        // int recIndex = listall.indexWhere(
                                        //     (element) =>
                                        //         element.songname ==
                                        //         player.getCurrentAudioTitle);

                                        // log(listall[recIndex + 1].songname!);
                                        // final recValue =
                                        //     addtorec(listall[recIndex + 1]);
                                        // updaterecentlyplayed(recValue);
                                        player.next();
                                        String tittle =
                                            player.getCurrentAudioTitle;
                                        song(tittle);
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.forward,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        player.toggleLoop();
                                        loop = loop == true ? false : true;
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.repeat,
                                        color: Colors.white,
                                      )),
                                  IconButton(
                                    onPressed: () {
                                      player.toggleShuffle();
                                    },
                                    icon: const Icon(
                                      FontAwesomeIcons.shuffle,
                                      color: Colors.white,
                                    ),
                                  ),
                                  // IconButton(
                                  //   onPressed: () async {
                                  //     await player
                                  //         .seekBy(const Duration(seconds: -10));
                                  //   },
                                  //   icon: const Icon(
                                  //     FontAwesomeIcons.arrowRotateLeft,
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                  // IconButton(
                                  //   onPressed: () async {
                                  //     String title =
                                  //         player.getCurrentAudioTitle;
                                  //     String artist =
                                  //         player.getCurrentAudioArtist;
                                  //     ScaffoldMessenger.of(context)
                                  //       ..removeCurrentSnackBar()
                                  //       ..showSnackBar(SnackBar(
                                  //         backgroundColor: sendory,
                                  //         content: Row(
                                  //           children: [
                                  //             Text(
                                  //               'generating Lyrics please wait',
                                  //               style: GoogleFonts.play(
                                  //                   color: primary,
                                  //                   fontSize: 17),
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
                                  //       ));
                                  //     String? lyric;
                                  //     setState(() {});
                                  //     Song? song = (await genius.searchSong(
                                  //         artist: title, title: artist));
                                  //     if (song != null) {
                                  //       // print(song.lyrics);
                                  //       log(song.lyrics.toString());
                                  //       lyric = song.lyrics;
                                  //     }
                                  //     if (lyric != null) {
                                  //       // ignore: use_build_context_synchronously
                                  //       // await Navigator.push(context,
                                  //       //     MaterialPageRoute(
                                  //       //   builder: (context) {
                                  //       //     return LyricsScreen(
                                  //       //       artist: artist,
                                  //       //       songname: title,
                                  //       //       lyrics: lyric ??
                                  //       //           'No Lyrics available for this song',
                                  //       //     );
                                  //       //   },
                                  //       // ));
                                  //       // ignore: use_build_context_synchronously
                                  //       showlirics(context, lyric);
                                  //     } else {
                                  //       ScaffoldMessenger.of(context)
                                  //         ..removeCurrentSnackBar()
                                  //         ..showSnackBar(SnackBar(
                                  //           backgroundColor: sendory,
                                  //           content: Row(
                                  //             children: [
                                  //               Text(
                                  //                 'Lyrics Not Available',
                                  //                 style: GoogleFonts.play(
                                  //                     color: primary,
                                  //                     fontSize: 17),
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
                                  //         ));
                                  //     }
                                  //   },
                                  //   icon: const Icon(
                                  //     FontAwesomeIcons.chartBar,
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                  IconButton(
                                    onPressed: () {
                                      String title =
                                          player.getCurrentAudioTitle;
                                      Songs fav = findcurrent(title);
                                      log(fav.songname.toString());
                                      List<Favsongs> favlist =
                                          favsongbox.values.toList();
                                      favlist
                                              .where((element) =>
                                                  element.songname ==
                                                  fav.songname)
                                              .isEmpty
                                          ? addfavs(
                                              Favsongs(
                                                songname: fav.songname,
                                                artist: fav.artist,
                                                duration: fav.duration,
                                                songurl: fav.songurl,
                                                id: fav.id,
                                              ),
                                              context)
                                          : deletefavs(
                                              Favsongs(
                                                songname: fav.songname,
                                                artist: fav.artist,
                                                duration: fav.duration,
                                                songurl: fav.songurl,
                                                id: fav.id,
                                              ),
                                              context,
                                              listall);
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      favicon,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 30, right: 30),
                          //   child:
                          // )
                        ]),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    ));
  }

  findcurrent(String title) {
    for (Songs song in listall) {
      if (song.songname == title) {
        return song;
      }
    }
  }
}

addfavs(Favsongs favson, BuildContext context) async {
  await favsongbox.add(favson);
  favoritelistener.value.add(favson);
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(
      backgroundColor: sendory,
      content: Row(
        children: [
          Text(
            'Song Added to Favorites',
            style: GoogleFonts.play(color: primary, fontSize: 17),
          ),
          const SizedBox(
            width: 10,
          ),
          Icon(
            Icons.info,
            color: primary,
          )
        ],
      ),
    ));
}

deletefavs(Favsongs favson, BuildContext context, songlist) async {
  List<Favsongs> fav = favsongbox.values.toList();
  int idx = fav.indexWhere((element) => element.songname == favson.songname);
  await favsongbox.deleteAt(idx);

  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: sendory,
        content: Row(
          children: [
            Text(
              'Song Removed from Favorites',
              style: GoogleFonts.play(color: primary, fontSize: 17),
            ),
            const SizedBox(
              width: 10,
            ),
            Icon(
              Icons.info,
              color: primary,
            )
          ],
        ),
      ),
    );
}
// if(Favoriteslist)
// if (item.songname == title) {
//         await favsongbox.add(Favsongs(
//             songname: item.songname,
//             artist: item.artist,
//             duration: item.duration,
//             songurl: item.songurl,
//             id: item.id));
//         favoritelistener.value.add(Favsongs(
//             songname: item.songname,
//             artist: item.artist,
//             duration: item.duration,
//             songurl: item.songurl,
//             id: item.id));
//         ScaffoldMessenger.of(context)
//           ..removeCurrentSnackBar()
//           ..showSnackBar(SnackBar(
//             backgroundColor: sendory,
//             content: Row(
//               children: [
//                 Text(
//                   'Song Added to Favorites',
//                   style: GoogleFonts.play(color: primary, fontSize: 17),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Icon(
//                   Icons.info,
//                   color: primary,
//                 )
//               ],
//             ),
//           ));
//       }
//     }