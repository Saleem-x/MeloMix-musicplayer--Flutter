import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/bloc/playlist/playlist_bloc.dart';
import 'package:music_player/bloc/popupmenu/popupmenu_bloc.dart';
import 'package:music_player/db/models/db_model.dart';
import 'package:music_player/db/models/favoritesmodel/favoritesmodel.dart';
import 'package:music_player/db/models/playlismodel/playlistmodel.dart';
import 'package:music_player/screens/favorites/favoriteslist.dart';
import 'package:music_player/screens/playlist/createpalylist.dart';
import 'package:music_player/widgets/cardsmain.dart';
import '../../db/functions/db_functions.dart';
import '../../materials/material.dart';

// ignore: must_be_immutable
class Popupmenu extends StatelessWidget {
  final List<Songs> songs;
  IconData favicon;
  final double height;
  final int idx;
  Popupmenu(
      {super.key,
      required this.songs,
      required this.height,
      required this.idx,
      required this.favicon});

  List<Favsongs> favsong = [];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocBuilder<PopupmenuBloc, PopupmenuState>(
          builder: (context, state) {
            favsong = state.favoritesongs.values.toList();
            return IconButton(
              onPressed: () {
                Favsongs favson = Favsongs(
                    songname: songs[idx].songname,
                    artist: songs[idx].artist,
                    duration: songs[idx].duration,
                    songurl: songs[idx].songurl,
                    id: songs[idx].id);

                state.favoritesongs.values
                        .where((element) =>
                            element.songname == songs[idx].songname)
                        .isEmpty
                    ? addfavs(favson, context)
                    : deletefavs(favson, context, songs);
              },
              icon: Icon(
                state.favoritesongs.values
                        .where((element) =>
                            element.songname == songs[idx].songname)
                        .isEmpty
                    ? Icons.favorite_border
                    : Icons.favorite,
                color: sendory,
              ),
            );
          },
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
                      height: height * 0.3,
                      child: BlocBuilder<PlaylistBloc, PlaylistState>(
                        builder: (context, state) {
                          List<Playlistsongs> playlists =
                              state.playlistbox.values.toList();
                          return state.playlistbox.isEmpty
                              ? Padding(
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
                                      height: height * 0.20,
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
                                )
                              : Padding(
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
                                          height: height * 0.20,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  var a = playlistbox.values
                                                      .toList();

                                                  bool contains = false;
                                                  for (var item in a[index]
                                                      .playlistsongs!) {
                                                    if (item.songname ==
                                                        songs[idx].songname) {
                                                      contains = true;
                                                    }
                                                  }

                                                  if (contains == true) {
                                                    ScaffoldMessenger.of(
                                                        context)
                                                      ..removeCurrentSnackBar()
                                                      ..showSnackBar(
                                                        SnackBar(
                                                          backgroundColor:
                                                              sendory,
                                                          content: Row(
                                                            children: [
                                                              Text(
                                                                'Song already in Playlist',
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
                                                  } else if (contains ==
                                                      false) {
                                                    var a = playlistbox
                                                        .getAt(index);
                                                    a!.playlistsongs!
                                                        .add(songs[idx]);
                                                    playlistbox.putAt(index, a);
                                                    ScaffoldMessenger.of(
                                                        context)
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
                      ),
                    );
                  });
            }
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          itemBuilder: (context) => [
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

  addfavs(Favsongs favson, BuildContext context) async {
    await favsongbox.add(favson);
    favoritelistener.value.add(favson);
    // ignore: use_build_context_synchronously
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
    // ignore: use_build_context_synchronously
    BlocProvider.of<PopupmenuBloc>(context)
        .add(AddtoFavEvent(favoritesongs: favsongbox));
  }

  deletefavs(Favsongs favson, BuildContext context, songlist) async {
    int currentidx =
        favsong.indexWhere((element) => element.id == songlist[idx].id);
    await favsongbox.deleteAt(currentidx);
    favoritelistener.value.remove(favson);
    // ignore: use_build_context_synchronously
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
    // ignore: use_build_context_synchronously
    BlocProvider.of<PopupmenuBloc>(context)
        .add(AddtoFavEvent(favoritesongs: favsongbox));
  }
}
