// import 'dart:developer';

// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
// import 'package:marquee/marquee.dart';
// import 'package:music_player/db/functions/db_functions.dart';
// import 'package:music_player/db/models/db_model.dart';
// import 'package:music_player/db/models/recentmodel/recentmodel.dart';
// import 'package:music_player/screens/commonscreens/player.dart';
// import 'package:music_player/screens/homescreen/homescreen.dart';

// import 'package:on_audio_query/on_audio_query.dart';

// // ignore: camel_case_types
// class playingCard extends StatefulWidget {
//   /* int index; */
//   const playingCard({
//     super.key,
//     /* required this.index */
//   });

//   @override
//   State<playingCard> createState() => _playingCardState();
// }

// class _playingCardState extends State<playingCard> {
//   @override
//   Widget build(BuildContext context) {
//     return player.builderCurrent(builder: (context, playing) {
//       return Container(
//         height: 60,
//         width: MediaQuery.of(context).size.width,
//         color: Colors.black,
//         child: ListTile(
//           onTap: (() {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: ((context) => const PlayerScreen())));
//           }),
//           contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 10),
//           leading: QueryArtworkWidget(
//             id: int.parse(playing.audio.audio.metas.id!),
//             type: ArtworkType.AUDIO,
//             artworkWidth: 50,
//             artworkHeight: 50,
//             artworkFit: BoxFit.fill,
//             nullArtworkWidget: ClipRect(
//               child: Image.asset(
//                 "assets/Music Brand and App Logo (1).png",
//                 fit: BoxFit.cover,
//                 width: 50,
//                 height: 50,
//               ),
//             ),
//           ),
//           title: Marquee(
//             text: player.getCurrentAudioTitle,
//             style: const TextStyle(color: Colors.white),
//             blankSpace: 80,
//             pauseAfterRound: const Duration(seconds: 2),
//           ),
//           trailing: PlayerBuilder.isPlaying(
//             player: player,
//             builder: (context, isPlaying) {
//               return Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                       onPressed: () async {
//                         await player.previous();
//                         setState(() {});
//                         if (isPlaying == false) {
//                           player.pause();
//                         }
//                       },
//                       icon: const Icon(
//                         Icons.skip_previous,
//                         color: Colors.white,
//                       )),
//                   IconButton(
//                     onPressed: () {
//                       player.playOrPause();
//                     },
//                     icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
//                     color: Colors.white,
//                   ),
//                   IconButton(
//                       onPressed: () async {
//                         await player.next();
//                         setState(() {});
//                         if (isPlaying == false) {
//                           player.pause();
//                         }
//                       },
//                       icon: const Icon(
//                         Icons.skip_next,
//                         color: Colors.white,
//                       ))
//                 ],
//               );
//             },
//           ),
//         ),
//       );
//     });
//   }
// }
