import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_player/materials/material.dart';
// import 'package:music_player/screens/all_songs.dart';

class MiniPlayerNull extends StatelessWidget {
  const MiniPlayerNull({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          backgroundColor: sendory,
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return const AllSongs();
            // }));
          },
          child: Icon(
            FontAwesomeIcons.circlePlay,
            color: primary,
          ),
        ));
  }
}
// Container(
//         height: 100,
//         width: double.infinity,
//         decoration: BoxDecoration(
//             color: sendory,
//             borderRadius: const BorderRadius.all(Radius.circular(30))),
//         child: ListTile(
//           contentPadding: const EdgeInsets.only(left: 15),
//           title: Padding(
//             padding: EdgeInsets.all(20),
//             child: Marquee(
//               pauseAfterRound: const Duration(seconds: 2),
//               blankSpace: 30,
//               startPadding: 0,
//               text: 'NO Songs Is Currently Playings',
//               style: TextStyle(
//                   color: primary, fontSize: 17, fontWeight: FontWeight.bold),
//             ),
//           ),
//           leading: Padding(
//             padding: const EdgeInsets.only(top: 10),
//             child: CircleAvatar(
//               radius: 30,
//               backgroundColor: primary,
//               child: ClipOval(
//                 child: QueryArtworkWidget(
//                   id: 0,
//                   type: ArtworkType.AUDIO,
//                   nullArtworkWidget: Image.asset(
//                       'assets/images/Retro_cassette_tape_vector-removebg-preview (2).png'),
//                 ),
//               ),
//             ),
//           ),
//         ));