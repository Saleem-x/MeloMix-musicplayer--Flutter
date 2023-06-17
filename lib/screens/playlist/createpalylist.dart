import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_player/db/functions/db_functions.dart';
import 'package:music_player/db/models/db_model.dart';
import 'package:music_player/db/models/playlismodel/playlistmodel.dart';
import 'package:music_player/materials/material.dart';
import 'package:music_player/screens/playlist/playlistwidget.dart';
import 'package:music_player/screens/searchscreen/searchwidget.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../bloc/playlist/playlisticon.dart';

class CreateplayList extends StatefulWidget {
  const CreateplayList({super.key});

  @override
  State<CreateplayList> createState() => _CreateplayListState();
}

class _CreateplayListState extends State<CreateplayList> {
  final controller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // IconData icon = Icons.add_circle;
    List<Songs> plsongs = [];
    // List<Songs> temp = [];
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: sendory,
      body: Column(
        children: [
          Row(
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
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: height * 0.3,
              width: width,
              decoration: BoxDecoration(
                  color: primary,
                  borderRadius: const BorderRadius.all(Radius.circular(60)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2.5,
                      blurRadius: 5,
                      offset: const Offset(6, 6),
                      inset: true,
                    ),
                  ]),
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Create Play List',
                        style: TextStyle(
                            color: sendory,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter name';
                          } else {
                            return null;
                          }
                        },
                        controller: controller,
                        style: TextStyle(color: sendory),
                        decoration: InputDecoration(
                          label: const Text('Enter Play List Name'),
                          labelStyle: TextStyle(color: sendory, fontSize: 17),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: sendory, width: 2.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    InkWell(
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          playlistbox.add(Playlistsongs(
                              playlistname: controller.text,
                              playlistsongs: plsongs));
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
                        height: height * 0.07,
                        width: width * 0.5,
                        decoration: BoxDecoration(
                            color: sendory,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(60)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 2.5,
                                blurRadius: 5,
                                offset: const Offset(6, 6),
                                inset: true,
                              ),
                            ]),
                        child: Center(
                          child: Text(
                            'Create',
                            style: TextStyle(
                                color: primary,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.03),
          Expanded(
            child: Container(
              width: double.infinity,
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
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: primary),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    Songs songs = listall[index];
                    // List<bool> icons = [false];
                    return ListTile(
                      onTap: () {},
                      title: Text(
                        songs.songname!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        songs.artist!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white),
                      ),
                      leading: CircleAvatar(
                          backgroundColor: sendory,
                          child: QueryArtworkWidget(
                              nullArtworkWidget: Image.asset(
                                  'assets/images/Retro_cassette_tape_vector-removebg-preview (2).png'),
                              id: songs.id!,
                              type: ArtworkType.AUDIO)),
                      trailing: IconButton(
                        onPressed: () {
                          Songs song = listall[index];
                          if (plsongs.contains(listall[index])) {
                            plsongs.remove(song);
                            context.read<IconCubit>().add();
                            // widget.icon = Icons.add_circle;
                          } else {
                            plsongs.add(song);
                            context.read<IconCubit>().remove();
                            // widget.icon = Icons.remove_circle;
                          }
                          // setState(() {});
                        },
                        icon: BlocBuilder<IconCubit, IconData>(
                          builder: (context, state) {
                            return Icon(
                              state,
                              color: sendory,
                            );
                          },
                        ),
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
                  itemCount: listall.length),
            ),
          )
        ],
      ),
    ));
  }

  change(List<Songs> plsong, index, icon) {
    plsong
            .where((element) => element.songname == listall[index].songname)
            .isEmpty
        ? icon = Icons.add_circle
        : icon = Icons.remove_circle;

    // int? idx;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            plsong.add(listall[index]);
            plsong
                    .where((element) =>
                        element.songname == listall[index].songname)
                    .isEmpty
                ? icon = Icons.add_circle
                : icon = Icons.remove_circle;
            setState(() {});
          },
          icon: Icon(
            icon,
            color: sendory,
          ),
        ),
      ],
    );
  }
}
