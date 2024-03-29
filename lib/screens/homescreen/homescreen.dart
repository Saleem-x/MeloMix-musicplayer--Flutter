import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/screens/albums/albumscreen.dart';
import 'package:music_player/screens/favorites/favoritescreen.dart';
import 'package:music_player/screens/findmusic/findMusic.dart';
import 'package:music_player/screens/mostplayed/mostlyplayed.dart';
import 'package:music_player/screens/playlist/playlist.dart';
import 'package:music_player/screens/recentlyplayed/recentlist.dart';
import 'package:music_player/screens/searchscreen/searchscreen.dart';
import 'package:music_player/screens/settings.dart';
import 'package:music_player/widgets/cardsmain.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../db/models/db_model.dart';
import '../../materials/material.dart';
import '../allsongs/all_songs.dart';
import '../miniplayer/miniplayer.dart';
import 'package:page_transition/page_transition.dart';

AssetsAudioPlayer player = AssetsAudioPlayer();
Songs? currentlyplaying;
List<Audio> playinglistAudio = [];
List<Audio> currentplaylist = [];
List<Audio> currentfavlist = [];
List<Audio> mostplay = [];

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final audioquery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: sendory,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: const Settings()));
                      },
                      child: Container(
                        height: height * 0.05,
                        width: width * 0.14,
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
                          color: primary,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: const Icon(
                          Icons.grid_view,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) {
                              return SearchScreen();
                            }),
                          ),
                        );
                      },
                      child: Container(
                        height: height * 0.1,
                        width: width * 0.3,
                        decoration: BoxDecoration(
                          color: primary,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1.5,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                              inset: true,
                            ),
                          ],
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(120),
                          ),
                        ),
                        child: const Icon(
                          FontAwesomeIcons.magnifyingGlass,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.09,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Melo',
                        style: GoogleFonts.play(
                            color: primary,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Mix',
                        style: GoogleFonts.play(
                            color: primary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const AllSongs(
                                  // audioquery: audioquery,
                                  );
                            }));
                          },
                          child: const CardsList(
                              idx: 1,
                              icon: FontAwesomeIcons.music,
                              ftitle: 'ALL',
                              stitle: 'Songs'),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const PlayList();
                            }));
                          },
                          child: const CardsList(
                              idx: 0,
                              icon: Icons.queue_music_rounded,
                              ftitle: 'Play',
                              stitle: 'List'),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const FavoriteScreen();
                            }));
                          },
                          child: const CardsList(
                              idx: 1,
                              icon: FontAwesomeIcons.heart,
                              ftitle: 'Favourite',
                              stitle: 'songs'),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const MostlyPlayed();
                            }));
                          },
                          child: const CardsList(
                              idx: 0,
                              icon: Icons.album,
                              ftitle: 'Mostly',
                              stitle: 'Played'),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return FindMusic();
                            }));
                          },
                          child: const CardsList(
                              idx: 1,
                              icon: Icons.radar,
                              ftitle: 'Find',
                              stitle: 'Song'),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AlbumScreen();
                            }));
                          },
                          child: const CardsList(
                              idx: 0,
                              icon: Icons.my_library_music_rounded,
                              ftitle: 'Albums',
                              stitle: 'You Have'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Recently Played',
                    style: TextStyle(
                        color: primary,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
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
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        color: primary),
                    child: const RecentList(),
                  ),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MiniPlayer(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
