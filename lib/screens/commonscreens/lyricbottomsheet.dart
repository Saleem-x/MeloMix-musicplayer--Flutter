import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/materials/material.dart';

showlirics(BuildContext context, String lyrics) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Column(children: [
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
                  // ignore: unnecessary_null_comparison
                  lyrics != null
                      ? Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            lyrics.replaceAll('Contributor', ''),
                            style: GoogleFonts.play(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ))
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [Text('No Lyrics available')],
                        )
                ],
              )),
        )
      ]);
    },
  );
}
