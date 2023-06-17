import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/bloc/playlist/playlist_bloc.dart';
import 'package:music_player/db/functions/playerfunctions.dart';
import 'package:music_player/db/models/db_model.dart';
import 'package:music_player/materials/material.dart';
import 'package:music_player/screens/miniplayer/miniplayer.dart';
import 'package:music_player/screens/playlist/functions.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class Playlistsongview extends StatelessWidget {
  List<Songs> songtoplay;
  final String playlistname;
  final int plindex;
  Playlistsongview(
      {super.key,
      required this.playlistname,
      required this.plindex,
      required this.songtoplay});

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
                      playlistname,
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
                      child: songtoplay.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset('assets/common-empty.json'),
                                  const Text(
                                    'No Songs Added',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          : BlocBuilder<PlaylistBloc, PlaylistState>(
                              builder: (context, state) {
                                songtoplay = state.playlistbox.values
                                    .toList()[plindex]
                                    .playlistsongs!;
                                return ListView.separated(
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        onTap: () {
                                          playlistAudios(songtoplay, index);
                                          log(songtoplay[index].id!.toString());
                                          // int tid;
                                        },
                                        title: Text(songtoplay[index].songname!,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.play(
                                                fontSize: 17,
                                                color: Colors.white)),
                                        subtitle: Text(
                                            songtoplay[index].artist!,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.play(
                                                fontSize: 17,
                                                color: Colors.white)),
                                        leading: CircleAvatar(
                                          backgroundColor: sendory,
                                          child: ClipOval(
                                            child: QueryArtworkWidget(
                                              id: songtoplay[index].id!,
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
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      backgroundColor: primary,
                                                      title: Text(
                                                        'Delete Song',
                                                        style: TextStyle(
                                                            color: sendory),
                                                      ),
                                                      content: Text(
                                                          'Do You Want to delete this song',
                                                          style: TextStyle(
                                                              color: sendory)),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child: Text('Cancel',
                                                              style: TextStyle(
                                                                  color:
                                                                      sendory)),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        TextButton(
                                                          child: Text('OK',
                                                              style: TextStyle(
                                                                  color:
                                                                      sendory)),
                                                          onPressed: () {
                                                            deletesong(
                                                                index,
                                                                plindex,
                                                                context);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              icon: const Icon(
                                                FontAwesomeIcons
                                                    .ellipsisVertical,
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
                                    itemCount: songtoplay.length);
                              },
                            ),
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
