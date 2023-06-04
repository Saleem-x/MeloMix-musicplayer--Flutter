import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/db/functions/db_functions.dart';
import 'package:music_player/db/models/playlismodel/playlistmodel.dart';
import 'package:music_player/screens/miniplayer/miniplayer.dart';
import 'package:music_player/screens/playlist/createpalylist.dart';
import 'package:music_player/screens/playlist/playlistview.dart';
import 'package:music_player/widgets/cardsmain.dart';
import '../../materials/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class PlayList extends StatefulWidget {
  const PlayList({
    super.key,
  });

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    TextEditingController renamecontroller = TextEditingController();
    return Scaffold(
      backgroundColor: sendory,
      body: SafeArea(
        child: Column(children: [
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
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                height: height * 0.05,
                width: width * 0.5,
                alignment: Alignment.centerLeft,
                child: Center(
                  child: Text(
                    'Playlists',
                    style: GoogleFonts.roboto(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const CreateplayList();
                    },
                  ));
                },
                child: Container(
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
                        bottomLeft: Radius.circular(30)),
                  ),
                  height: 35,
                  width: 55,
                  alignment: Alignment.center,
                  child: Center(
                      child: Icon(
                    Icons.add,
                    color: sendory,
                  )),
                ),
              )
            ],
          ),
          SizedBox(
            height: height / 20,
          ),
          ValueListenableBuilder(
            valueListenable: playlistbox.listenable(),
            builder: (context, Box<Playlistsongs> playlistbox, child) {
              List<Playlistsongs> playlists = playlistbox.values.toList();
              return Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    SizedBox(
                      height: double.infinity,
                      child: playlists.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset('assets/common-empty.json'),
                                  Text(
                                    'No Playlist available',
                                    style: GoogleFonts.play(
                                        fontSize: 17, color: primary),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: playlists.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return Playlistsongview(
                                          songtoplay:
                                              playlists[index].playlistsongs!,
                                          playlistname:
                                              playlists[index].playlistname,
                                          plindex: index,
                                        );
                                      },
                                    ));
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    color: primary,
                                    child: Container(
                                      height: height * 0.09,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            spreadRadius: 1.5,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                            inset: true,
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.queue_music_rounded,
                                                    color: sendory,
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.02,
                                                  ),
                                                  Text(
                                                    playlists[index]
                                                        .playlistname,
                                                    style: TextStyle(
                                                        color: sendory,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                              PopupMenuButton(
                                                onSelected: (value) {
                                                  if (value == 0) {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              primary,
                                                          title: Text(
                                                            'Delete Playlist',
                                                            style: TextStyle(
                                                                color: sendory),
                                                          ),
                                                          content: Text(
                                                              'Do You Want to delete  ${playlists[index].playlistname}',
                                                              style: TextStyle(
                                                                  color:
                                                                      sendory)),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: Text(
                                                                  'Cancel',
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
                                                                playlistbox
                                                                    .deleteAt(
                                                                        index);
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  } else if (value == 1) {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: (context) {
                                                        // renamecontroller.text =
                                                        //     playlists[index]
                                                        //         .playlistname;
                                                        return Container(
                                                          height: height * 0.2,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color:
                                                                      primary),
                                                          child: Form(
                                                            key: formkey,
                                                            child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        20.0),
                                                                    child:
                                                                        TextFormField(
                                                                      controller:
                                                                          renamecontroller,
                                                                      validator:
                                                                          (value) {
                                                                        if (value ==
                                                                                null ||
                                                                            value.isEmpty) {
                                                                          return 'enter new name';
                                                                        } else {
                                                                          return null;
                                                                        }
                                                                      },
                                                                      style: TextStyle(
                                                                          color:
                                                                              sendory),
                                                                      decoration:
                                                                          InputDecoration(
                                                                        label: const Text(
                                                                            'Enter Play List Name'),
                                                                        labelStyle: TextStyle(
                                                                            color:
                                                                                sendory,
                                                                            fontSize:
                                                                                17),
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: sendory,
                                                                              width: 2.0),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        focusedBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide: const BorderSide(
                                                                              color: Colors.green,
                                                                              width: 2.0),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      if (formkey
                                                                          .currentState!
                                                                          .validate()) {
                                                                        renameplaylist(
                                                                            index,
                                                                            renamecontroller.text);
                                                                        setState(
                                                                            () {});
                                                                        Navigator.pop(
                                                                            context);
                                                                      }
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          height *
                                                                              0.05,
                                                                      width:
                                                                          width *
                                                                              0.3,
                                                                      decoration: BoxDecoration(
                                                                          color:
                                                                              sendory,
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
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          'Update',
                                                                          style: TextStyle(
                                                                              color: primary,
                                                                              fontSize: 17,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ]),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  }
                                                },
                                                color: sendory,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 0,
                                                    child: Text(
                                                      'Delete playlist',
                                                      style: TextStyle(
                                                          color: primary,
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 1,
                                                    child: Text(
                                                      'Edit PlayList Name',
                                                      style: TextStyle(
                                                          color: primary,
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )),
                                    ),
                                  ),
                                );
                              },
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
              ));
            },
          ),
        ]),
      ),
    );
  }
}

createcard() {
  GestureDetector(
    onTap: () {},
    child: const CardsList(
        idx: 1,
        icon: Icons.queue_music_rounded,
        ftitle: 'Play List',
        stitle: 'One'),
  );
}
