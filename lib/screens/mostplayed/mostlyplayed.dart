import 'dart:developer';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/db/functions/db_functions.dart';
import 'package:music_player/db/functions/playerfunctions.dart';
import 'package:music_player/db/models/db_model.dart';
import 'package:music_player/db/models/mostplayedmodel/mostplayed.dart';
import 'package:music_player/screens/commonscreens/popupmenu.dart';
import 'package:music_player/screens/mostplayed/functions.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../materials/material.dart';
import '../miniplayer/miniplayer.dart';

List<MostPlayed> allmpsongs = mostplayedsongs.values.toList();
List<MostPlayed> tolist = [];

class MostlyPlayed extends StatelessWidget {
  const MostlyPlayed({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    List<Songs> favl = [];
    return Scaffold(
      backgroundColor: sendory,
      body: SafeArea(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  log(allmpsongs[1].count.toString());
                  // allmpsongs.clear();
                  // mostplayedsongs.clear();
                  log(mostplayedsongs.length.toString());
                  // mostplayedsongs.clear();

                  Navigator.of(context).pop();
                },
                icon: Icon(
                  FontAwesomeIcons.chevronLeft,
                  color: primary,
                ),
              ),
              Container(
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
                    'Mostly Played',
                    style: GoogleFonts.roboto(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
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
                      topLeft: Radius.circular(60),
                    ),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: ValueListenableBuilder(
                        valueListenable: mostplayedsongs.listenable(),
                        builder: (context, mostplayedsongs, child) {
                          // allmpsongs = mostplayedsongs.values.toList();
                          tolist = addtolist();
                          if (tolist.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset('assets/search-not-found.json'),
                                  const Text(
                                    'Play more Songs',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            );
                          }
                          return ListView.separated(
                              itemBuilder: (context, index) {
                                converttolist(tolist, favl);
                                return ListTile(
                                  onTap: () {
                                    playmostplayed(tolist, index);
                                    updatecount(tolist[index]);
                                  },
                                  title: Text(tolist[index].songname,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.play(
                                          color: Colors.white)),
                                  subtitle: Text(
                                      tolist[index]
                                          .artist
                                          .toUpperCase()
                                          .toLowerCase()
                                          .replaceAll('?', ''),
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.play(
                                          color: Colors.white)),
                                  leading: CircleAvatar(
                                    backgroundColor: sendory,
                                    child: ClipOval(
                                      child: QueryArtworkWidget(
                                        id: tolist[index].id,
                                        type: ArtworkType.AUDIO,
                                        nullArtworkWidget: Image.asset(
                                            'assets/images/Retro_cassette_tape_vector-removebg-preview (2).png'),
                                      ),
                                    ),
                                  ),
                                  trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              color: sendory,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Center(
                                            child: Text(
                                              tolist[index].count.toString(),
                                              style: TextStyle(color: primary),
                                            ),
                                          ),
                                        ),
                                        Popupmenu(
                                            favicon: Icons.favorite,
                                            height: height,
                                            index: index,
                                            songs: favl)
                                      ]),
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
                              itemCount:
                                  tolist.length >= 15 ? 15 : tolist.length);
                        },
                      )),
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
        ],
      )),
    );
  }

  updatecount(MostPlayed data) {
    int idx = allmpsongs.indexWhere((element) => element == data);
    int count = data.count!;
    data.count = count + 1;
    mostplayedsongs.put(idx, data);
  }
}
