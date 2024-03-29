import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genius_lyrics/genius_lyrics.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee/marquee.dart';
import 'package:music_player/bloc/currentplaying/playerscreen_bloc.dart';
import 'package:music_player/bloc/popupmenu/popupmenu_bloc.dart';
import 'package:music_player/db/functions/db_functions.dart';
import 'package:music_player/db/models/db_model.dart';
import 'package:music_player/db/models/favoritesmodel/favoritesmodel.dart';
import 'package:music_player/screens/commonscreens/lyricbottomsheet.dart';
import 'package:music_player/screens/miniplayer/miniplayer.dart';
import 'package:music_player/screens/searchscreen/searchwidget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../materials/material.dart';
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

class _PlayerScreenState extends State<PlayerScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool isturninig = false;
  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    var loop = false;
    Duration duration = Duration.zero;
    Duration position = Duration.zero;

    return SafeArea(
        child: Scaffold(
      backgroundColor: sendory,
      body: SafeArea(
        child: PlayerBuilder.current(
          player: player,
          builder: (context, playing) {
            // favsong
            //         .where((element) =>
            //             element.songname == player.getCurrentAudioTitle)
            //         .isEmpty
            //     ? favicon = Icons.favorite_border
            //     : favicon = Icons.favorite;
            find(player.getCurrentAudioTitle, context);
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
                          SizedBox(
                            width: double.infinity,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: PlayerBuilder.isPlaying(
                                    player: player,
                                    builder: (context, isPlaying) {
                                      return RotationTransition(
                                        turns: isturninig
                                            ? Tween(begin: 0.0, end: 0.0)
                                                .animate(controller!.view)
                                            : Tween(begin: 0.0, end: 1.0)
                                                .animate(controller!.view),
                                        child: CircleAvatar(
                                          backgroundColor: sendory,
                                          radius: 90,
                                          child: ClipOval(
                                            child: SizedBox.fromSize(
                                              size: const Size.fromRadius(90),
                                              child: QueryArtworkWidget(
                                                id: int.parse(playing
                                                    .audio.audio.metas.id!),
                                                type: ArtworkType.AUDIO,
                                                nullArtworkWidget: Image.asset(
                                                  'assets/images/Retro_cassette_tape_vector-removebg-preview (2).png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  right: 30,
                                  child: BlocBuilder<PlayerscreenBloc,
                                      PlayerscreenState>(
                                    builder: (context, state) {
                                      return state.isloading
                                          ? SizedBox(
                                              height: 50,
                                              width: 50,
                                              child: Lottie.asset(
                                                  'assets/loadinganimation.json'),
                                            )
                                          : IconButton(
                                              icon: const Icon(
                                                Icons.lyrics,
                                                size: 40,
                                                color: Colors.white,
                                              ),
                                              onPressed: () async {
                                                BlocProvider.of<
                                                            PlayerscreenBloc>(
                                                        context)
                                                    .add(LoadingEvent(true));
                                                String title =
                                                    player.getCurrentAudioTitle;
                                                String artist = player
                                                    .getCurrentAudioArtist;
                                                ScaffoldMessenger.of(context)
                                                  ..removeCurrentSnackBar()
                                                  ..showSnackBar(SnackBar(
                                                    backgroundColor: sendory,
                                                    content: Row(
                                                      children: [
                                                        Text(
                                                          'generating Lyrics please wait',
                                                          style:
                                                              GoogleFonts.play(
                                                                  color:
                                                                      primary,
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
                                                String? lyric;
                                                Song? song =
                                                    (await genius.searchSong(
                                                        artist: title,
                                                        title: artist));
                                                if (song != null) {
                                                  lyric = song.lyrics;
                                                }
                                                if (lyric != null) {
                                                  // ignore: use_build_context_synchronously
                                                  showlirics(context, lyric);
                                                  // ignore: use_build_context_synchronously
                                                  BlocProvider.of<
                                                              PlayerscreenBloc>(
                                                          context)
                                                      .add(LoadingEvent(false));
                                                } else {
                                                  // ignore: use_build_context_synchronously
                                                  ScaffoldMessenger.of(context)
                                                    ..removeCurrentSnackBar()
                                                    ..showSnackBar(SnackBar(
                                                      backgroundColor: sendory,
                                                      content: Row(
                                                        children: [
                                                          Text(
                                                            'Lyrics Not Available',
                                                            style: GoogleFonts
                                                                .play(
                                                                    color:
                                                                        primary,
                                                                    fontSize:
                                                                        17),
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
                                                  // ignore: use_build_context_synchronously
                                                  BlocProvider.of<
                                                              PlayerscreenBloc>(
                                                          context)
                                                      .add(LoadingEvent(false));
                                                }
                                              },
                                            );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.14,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 80,
                              right: 80,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                                        player.previous();
                                        String tittle =
                                            player.getCurrentAudioTitle;
                                        song(tittle, context);
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
                                        if (isPlaying == true) {
                                          isturninig = true;
                                          controller!.forward();
                                          controller!.repeat();
                                        } else {
                                          isturninig = false;
                                        }
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
                                        player.next();
                                        String tittle =
                                            player.getCurrentAudioTitle;
                                        song(tittle, context);
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
                                        ScaffoldMessenger.of(context)
                                          ..removeCurrentSnackBar()
                                          ..showSnackBar(
                                            SnackBar(
                                              backgroundColor: sendory,
                                              content: Row(
                                                children: [
                                                  Text(
                                                    'Loop mode Changed',
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
                                            ),
                                          );
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.repeat,
                                        color: Colors.white,
                                      )),
                                  IconButton(
                                    onPressed: () {
                                      player.toggleShuffle();
                                      ScaffoldMessenger.of(context)
                                        ..removeCurrentSnackBar()
                                        ..showSnackBar(
                                          SnackBar(
                                            backgroundColor: sendory,
                                            content: Row(
                                              children: [
                                                Text(
                                                  'Shuffle Enabled',
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
                                          ),
                                        );
                                    },
                                    icon: const Icon(
                                      FontAwesomeIcons.shuffle,
                                      color: Colors.white,
                                    ),
                                  ),
                                  BlocBuilder<PopupmenuBloc, PopupmenuState>(
                                    builder: (context, state) {
                                      String title =
                                          player.getCurrentAudioTitle;
                                      Songs fav = findcurrent(title);
                                      return IconButton(
                                        onPressed: () {
                                          // List<Favsongs> favlist =
                                          //     favsongbox.values.toList();
                                          state.favoritesongs.values
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
                                        },
                                        icon: Icon(
                                          state.favoritesongs.values
                                                  .where((element) =>
                                                      element.songname ==
                                                      fav.songname)
                                                  .isEmpty
                                              ? Icons.favorite_border
                                              : Icons.favorite,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
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

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}

addfavs(Favsongs favson, BuildContext context) async {
  await favsongbox.add(favson);
  // ignore: use_build_context_synchronously
  BlocProvider.of<PopupmenuBloc>(context)
      .add(AddtoFavEvent(favoritesongs: favsongbox));
  // ignore: use_build_context_synchronously
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
  // ignore: use_build_context_synchronously
  BlocProvider.of<PopupmenuBloc>(context)
      .add(AddtoFavEvent(favoritesongs: favsongbox));
  // ignore: use_build_context_synchronously
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
