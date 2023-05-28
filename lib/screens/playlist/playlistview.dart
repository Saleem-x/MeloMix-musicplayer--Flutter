import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/db/functions/playerfunctions.dart';
import 'package:music_player/db/models/db_model.dart';
import 'package:music_player/materials/material.dart';
import 'package:music_player/screens/miniplayer/miniplayer.dart';
import 'package:music_player/screens/playlist/functions.dart';
import 'package:music_player/screens/searchscreen/searchwidget.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class Playlistsongview extends StatefulWidget {
  Playlistsongview(
      {super.key,
      required this.songtoplay,
      required this.playlistname,
      required this.plindex});
  List<Songs> songtoplay;
  final String playlistname;
  final int plindex;

  @override
  State<Playlistsongview> createState() => _PlaylistsongviewState();
}

class _PlaylistsongviewState extends State<Playlistsongview> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
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
                      widget.playlistname,
                      style: TextStyle(
                          color: sendory,
                          fontSize: 17,
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
                      color: primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(60),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: widget.songtoplay.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset('assets/search-not-found.json'),
                                  const Text(
                                    'No Songs Added',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          : ListView.separated(
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    playlistAudios(widget.songtoplay, index);
                                    log(widget.songtoplay[index].id!
                                        .toString());
                                    // int tid;
                                  },
                                  title: Text(
                                      widget.songtoplay[index].songname!,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.play(
                                          fontSize: 17, color: Colors.white)),
                                  subtitle: Text(
                                      widget.songtoplay[index].artist!,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.play(
                                          fontSize: 17, color: Colors.white)),
                                  leading: CircleAvatar(
                                    backgroundColor: sendory,
                                    child: ClipOval(
                                      child: QueryArtworkWidget(
                                        id: widget.songtoplay[index].id!,
                                        type: ArtworkType.AUDIO,
                                        nullArtworkWidget: Image.asset(
                                            'assets/images/Retro_cassette_tape_vector-removebg-preview (2).png'),
                                      ),
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor: primary,
                                                title: Text(
                                                  'Delete Song',
                                                  style:
                                                      TextStyle(color: sendory),
                                                ),
                                                content: Text(
                                                    'Do You Want to delete this song',
                                                    style: TextStyle(
                                                        color: sendory)),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('Cancel',
                                                        style: TextStyle(
                                                            color: sendory)),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text('OK',
                                                        style: TextStyle(
                                                            color: sendory)),
                                                    onPressed: () {
                                                      deletesong(index,
                                                          widget.plindex);
                                                      setState(() {});
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          FontAwesomeIcons.ellipsisVertical,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
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
                              itemCount: widget.songtoplay.length),
                    ),
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
        ),
      ),
    );
  }
}
