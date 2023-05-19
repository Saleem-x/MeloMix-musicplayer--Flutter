import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/models/db_model.dart';
import 'package:music_player/db/models/favoritesmodel/favoritesmodel.dart';
import 'package:music_player/db/models/playlismodel/playlistmodel.dart';
import 'package:music_player/screens/favorites/favoriteslist.dart';
import 'package:music_player/screens/playlist/createpalylist.dart';
import 'package:music_player/widgets/cardsmain.dart';
import '../../db/functions/db_functions.dart';
import '../../materials/material.dart';

// ignore: must_be_immutable
class Popupmenu extends StatefulWidget {
  Popupmenu({
    super.key,
    required this.favicon,
    required this.height,
    required this.index,
    required this.songs,
  });
  final List<Songs> songs;
  IconData favicon;
  final double height;
  final int index;

  @override
  State<Popupmenu> createState() => _PopupmenuState();
}

class _PopupmenuState extends State<Popupmenu> {
  List<Favsongs> favsong = [];

  @override
  Widget build(BuildContext context) {
    IconData? icon;
    favsong = favsongbox.values.toList();
    setState(() {
      favsong
              .where((element) =>
                  element.songname == widget.songs[widget.index].songname)
              .isEmpty
          ? icon = Icons.favorite_border
          : icon = Icons.favorite;
    });
    // int? idx;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            Favsongs favson = Favsongs(
                songname: widget.songs[widget.index].songname,
                artist: widget.songs[widget.index].artist,
                duration: widget.songs[widget.index].duration,
                songurl: widget.songs[widget.index].songurl,
                id: widget.songs[widget.index].id);

            favsong
                    .where((element) =>
                        element.songname == widget.songs[widget.index].songname)
                    .isEmpty
                ? addfavs(favson)
                : deletefavs(favson, context, widget.songs);
            setState(() {});
          },
          icon: Icon(
            icon,
            color: sendory,
          ),
        ),
        PopupMenuButton(
          color: Colors.white,
          onSelected: (value) {
            if (value == 0) {
              showModalBottomSheet(
                  backgroundColor: primary,
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: widget.height * 0.3,
                      child: StatefulBuilder(
                        builder: (context, setState) {
                          return ValueListenableBuilder(
                            valueListenable: playlistbox.listenable(),
                            builder: (context, value, child) {
                              List<Playlistsongs> playlists =
                                  playlistbox.values.toList();
                              if (playlistbox.isEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Your playlist',
                                          style: TextStyle(
                                              color: sendory,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return const CreateplayList();
                                              },
                                            ));
                                          },
                                          icon: Icon(
                                            Icons.add_outlined,
                                            color: sendory,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: widget.height * 0.20,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {},
                                            child: const CardsList(
                                                idx: 0,
                                                icon:
                                                    Icons.queue_music_outlined,
                                                ftitle: 'No Playlist',
                                                stitle: 'available'),
                                          );
                                        },
                                        itemCount: 1,
                                      ),
                                    )
                                  ]),
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Your playlist',
                                            style: TextStyle(
                                                color: sendory,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                  builder: (context) {
                                                    return const CreateplayList();
                                                  },
                                                ));
                                              },
                                              icon: Icon(
                                                Icons.add_outlined,
                                                color: sendory,
                                              ))
                                        ],
                                      ),
                                      SizedBox(
                                        height: widget.height * 0.20,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                // Playlistsongs? plsongs =
                                                //     playlistbox.getAt(index);
                                                // List<Songs>? plnewsongs =
                                                //     plsongs!.playlistsongs;

                                                // playlistadd(
                                                //     plnewsongs!,
                                                //     widget.songs,
                                                //     index,
                                                //     widget.index,
                                                //     context);
                                                var a =
                                                    playlistbox.values.toList();

                                                bool contains = false;
                                                for (var item in a[index]
                                                    .playlistsongs!) {
                                                  if (item.songname ==
                                                      widget.songs[widget.index]
                                                          .songname) {
                                                    contains = true;
                                                  }
                                                }
                                                // a[index]
                                                //     .playlistsongs!
                                                //     .contains(widget
                                                //         .songs[widget.index])
                                                if (contains == true) {
                                                  ScaffoldMessenger.of(context)
                                                    ..removeCurrentSnackBar()
                                                    ..showSnackBar(
                                                      SnackBar(
                                                        backgroundColor:
                                                            sendory,
                                                        content: Row(
                                                          children: [
                                                            Text(
                                                              'Song  already in Playlist',
                                                              style: GoogleFonts
                                                                  .play(
                                                                      color:
                                                                          primary,
                                                                      fontSize:
                                                                          17),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Icon(
                                                              Icons.info,
                                                              color: primary,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  Navigator.pop(context);
                                                  log('allready');
                                                } else if (contains == false) {
                                                  var a =
                                                      playlistbox.getAt(index);
                                                  a!.playlistsongs!.add(widget
                                                      .songs[widget.index]);
                                                  playlistbox.putAt(index, a);
                                                  ScaffoldMessenger.of(context)
                                                    ..removeCurrentSnackBar()
                                                    ..showSnackBar(
                                                      SnackBar(
                                                        backgroundColor:
                                                            sendory,
                                                        content: Row(
                                                          children: [
                                                            Text(
                                                              'Song added to Playlist',
                                                              style: GoogleFonts
                                                                  .play(
                                                                      color:
                                                                          primary,
                                                                      fontSize:
                                                                          17),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Icon(
                                                              Icons.info,
                                                              color: primary,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  Navigator.pop(context);
                                                  log('added');
                                                }
                                              },
                                              child: CardsList(
                                                  idx: 0,
                                                  icon: Icons
                                                      .queue_music_outlined,
                                                  ftitle: playlists[index]
                                                      .playlistname,
                                                  stitle: 'Playlist'),
                                            );
                                          },
                                          itemCount: playlists.length,
                                        ),
                                      )
                                    ]),
                              );
                            },
                          );
                        },
                      ),
                    );
                  });
            }
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          itemBuilder: (context) => [
            // const PopupMenuItem(value: 1, child: Text('Add to favorites')),
            PopupMenuItem(
                value: 0,
                child: Text(
                  'Add to playlist',
                  style: GoogleFonts.play(
                    fontSize: 17,
                    color: primary,
                  ),
                ))
          ],
        )
      ],
    );
  }

  playlistadd(List<Songs> plnewsongs, List<Songs> songs, int index, int plidex,
      BuildContext context) {
    bool contains = false;
    for (var item in plnewsongs) {
      if (songs[index].songname == item.songname) {
        log('found');
        contains = true;
        break;
      } else {
        log('not found');
        contains = false;
      }
    }
    if (contains == false) {
      // plnewsongs.add(Songs(
      //     songname: songs[index].songname,
      //     artist: songs[index].artist,
      //     duration: songs[index].duration,
      //     id: songs[index].duration,
      //     songurl: songs[index].songurl));
      var a = playlistbox.getAt(plidex);
      a!.playlistsongs!.add(Songs(
          songname: songs[index].songname,
          artist: songs[index].artist,
          duration: songs[index].duration,
          id: songs[index].duration,
          songurl: songs[index].songurl));
      playlistbox.putAt(index, a);
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: sendory,
            content: Row(
              children: [
                Text(
                  'Song added to Playlist',
                  style: GoogleFonts.play(color: primary, fontSize: 17),
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.info,
                  color: primary,
                )
              ],
            ),
          ),
        );
      Navigator.pop(context);
      log('not found');
    } else {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: sendory,
            content: Row(
              children: [
                Text(
                  'Song  already in Playlist',
                  style: GoogleFonts.play(color: primary, fontSize: 17),
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.info,
                  color: primary,
                )
              ],
            ),
          ),
        );
      Navigator.pop(context);
    }
  }

  addfavs(Favsongs favson) async {
    await favsongbox.add(favson);
    favoritelistener.value.add(favson);
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        backgroundColor: sendory,
        content: Row(
          children: [
            Text(
              'Song Added to Favorites',
              style: GoogleFonts.play(color: primary, fontSize: 17),
            ),
            const SizedBox(
              width: 10,
            ),
            Icon(
              Icons.info,
              color: primary,
            )
          ],
        ),
      ));
  }

  deletefavs(Favsongs favson, BuildContext context, songlist) async {
    int currentidx = favsong
        .indexWhere((element) => element.id == songlist[widget.index].id);
    await favsongbox.deleteAt(currentidx);
    favoritelistener.value.remove(favson);
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: sendory,
          content: Row(
            children: [
              Text(
                'Song Removed from Favorites',
                style: GoogleFonts.play(color: primary, fontSize: 17),
              ),
              const SizedBox(
                width: 10,
              ),
              Icon(
                Icons.info,
                color: primary,
              )
            ],
          ),
        ),
      );
  }
}







//  if (idx != null) {
//               // removefav(listall[widget.index]);

//               var k = favsongbox.values.where((element) => element == favson);
              // favsongbox.delete(favson);
              // ScaffoldMessenger.of(context)
              //   ..removeCurrentSnackBar()
              //   ..showSnackBar(
              //     SnackBar(
              //       backgroundColor: sendory,
              //       content: Row(
              //         children: [
              //           Text(
              //             'Song Removed from Favorites',
              //             style: TextStyle(
              //                 color: primary,
              //                 fontSize: 17,
              //                 fontWeight: FontWeight.bold),
              //           ),
              //           const SizedBox(
              //             width: 10,
              //           ),
              //           Icon(
              //             Icons.info,
              //             color: primary,
              //           )
              //         ],
              //       ),
              //     ),
              //   );
//             } else {
//               // addtofav(listall[widget.index]);
//               // favoritelistener.value.add(listall[widget.index]);
//               // int currentindex = checkit.indexWhere(
//               //     (element) => element.id == listall[widget.index].id);
              // favsongbox.add(favson);
              // widget.favicon = Icons.favorite;
              // ScaffoldMessenger.of(context)
              //   ..removeCurrentSnackBar()
              //   ..showSnackBar(
              //     SnackBar(
              //       backgroundColor: sendory,
              //       content: Row(
              //         children: [
              //           Text(
              //             'Song Added to Favorites',
              //             style: TextStyle(
              //                 color: primary,
              //                 fontSize: 17,
              //                 fontWeight: FontWeight.bold),
              //           ),
              //           const SizedBox(
              //             width: 10,
              //           ),
              //           Icon(
              //             Icons.info,
              //             color: primary,
              //           )
              //         ],
              //       ),
              //     ),
              //   );
            // }