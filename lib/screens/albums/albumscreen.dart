import 'dart:developer';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/materials/material.dart';
import 'package:music_player/screens/albums/listalbum.dart';
import 'package:music_player/screens/miniplayer/miniplayer.dart';
import 'package:music_player/screens/searchscreen/searchwidget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  List<AlbumModel> albums = [];
  @override
  void initState() {
    fectchalbum();
    log(albums.length.toString());
    setState(() {});
    super.initState();
  }

  fectchalbum() async {
    albumListNotifier.value = await _audioQuery.queryAlbums();
  }

  ValueNotifier<List<AlbumModel>> albumListNotifier =
      ValueNotifier<List<AlbumModel>>([]);

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
                    'Albums',
                    style: GoogleFonts.roboto(
                        color: Colors.white,
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
                    padding: const EdgeInsets.only(top: 25),
                    child: ValueListenableBuilder(
                      valueListenable: albumListNotifier,
                      builder: (context, value, child) {
                        return ListAlbums(albums: value);
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
      )),
    );
  }
}
