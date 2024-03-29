import 'package:flutter/material.dart';
import 'package:music_player/db/models/db_model.dart';
import 'package:music_player/materials/material.dart';
import 'package:music_player/screens/searchscreen/searchwidget.dart';

// ignore: must_be_immutable
class PopUp2 extends StatefulWidget {
  PopUp2(
      {super.key,
      required this.plsongs,
      required this.index,
      required this.icon});
  final List<Songs> plsongs;
  final int index;
  IconData icon;

  @override
  State<PopUp2> createState() => _PopUp2State();
}

class _PopUp2State extends State<PopUp2> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            Songs song = listall[widget.index];
            if (widget.plsongs.contains(listall[widget.index])) {
              widget.plsongs.remove(song);
              widget.icon = Icons.add_circle;
            } else {
              widget.plsongs.add(song);
              widget.icon = Icons.remove_circle;
            }
            setState(() {});
          },
          icon: Icon(
            widget.icon,
            color: sendory,
          ),
        ),
      ],
    );
  }

  add(List<Songs> plsongs, icon, index) {
    icon = Icons.add_circle;
  }

  remove(List<Songs> plsongs, icon, index) {
    icon = Icons.remove;
  }
}
