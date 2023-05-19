import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../db/models/db_model.dart';
import '../../materials/material.dart';

// late List<Songs> searchdbSongs;
// List<Songs> listall = List.from(searchdbSongs);
final box = SongBox.getInstance();
List<Songs> listall = box.values.toList();

// class Searchlist extends StatefulWidget {
//   final ValueNotifier data;
//   final context;
//   const Searchlist({super.key, required this.data, this.context});

//   @override
//   State<Searchlist> createState() => _SearchlistState();
// }

// class _SearchlistState extends State<Searchlist> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

searchempty() {
  return ListView.separated(
      itemBuilder: (context, index) {
        Songs songs = listall[index];
        return ListTile(
          onTap: () {},
          title: Text(
            songs.songname!,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            overflow: TextOverflow.ellipsis,
            songs.artist!,
            style: const TextStyle(color: Colors.white),
          ),
          leading: CircleAvatar(
              backgroundColor: sendory,
              child: QueryArtworkWidget(
                id: songs.id!,
                type: ArtworkType.AUDIO,
                nullArtworkWidget: Image.asset(
                    'assets/images/Retro_cassette_tape_vector-removebg-preview (2).png'),
              )),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {},
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
      itemCount: listall.length);
}
