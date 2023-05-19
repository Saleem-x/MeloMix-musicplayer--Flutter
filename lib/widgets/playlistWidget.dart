// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_player/db/models/db_model.dart';
import '../materials/material.dart';

// ignore: must_be_immutable
class PlayListWidget extends StatelessWidget {
  List<Songs> list;
  PlayListWidget({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {},
            title: Text(
              list[index].songname!,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              list[index].artist!,
              style: const TextStyle(color: Colors.white),
            ),
            leading: CircleAvatar(backgroundColor: sendory),
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
        itemCount: list.length);
  }
}

empty() {
  Center(
    child: Column(
      children: const [
        Text(
          'No PlayList Selected',
          style: TextStyle(color: Colors.white),
        ),
        Text('or Selected Playelist Will be empty',
            style: TextStyle(color: Colors.white)),
      ],
    ),
  );
}
