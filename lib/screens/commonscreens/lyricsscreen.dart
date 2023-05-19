import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/materials/material.dart';

import 'functions.dart';

ValueNotifier<String> lyricnotifier = ValueNotifier(Lyrics!);

class LyricsScreen extends StatefulWidget {
  const LyricsScreen({
    super.key,
    required this.songname,
    required this.artist,
    required this.lyrics,
  });
  final String songname;
  final String artist;
  final String lyrics;
  @override
  State<LyricsScreen> createState() => _LyricsScreenState();
}

class _LyricsScreenState extends State<LyricsScreen> {
  @override
  void initState() {
    printlyrics(widget.songname, widget.artist);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: sendory,
      body: SafeArea(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Lyrics = null;
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
                    'Lyrics',
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
          SizedBox(
            height: height * 0.05,
          ),
          Expanded(
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: primary),
                child: ListView(
                  children: [
                    widget.lyrics != null
                        ? Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              widget.lyrics,
                              style: GoogleFonts.play(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ))
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [Text('No Lyrics available')],
                          )
                  ],
                )),
          )
        ]),
      ),
    );
  }
}
