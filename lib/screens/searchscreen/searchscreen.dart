import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/bloc/search/search_bloc.dart';
import 'package:music_player/db/functions/playerfunctions.dart';
import 'package:music_player/materials/material.dart';
import 'package:music_player/screens/commonscreens/popupmenu.dart';
import 'package:music_player/screens/searchscreen/searchwidget.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../db/models/db_model.dart';
import '../miniplayer/miniplayer.dart';
// List<Songs> searchsongs = [];
// List<Songs> dbsongs = listall;

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  List<Songs> dbsongs = listall;

  List<Songs> searchsongs = listall;
  final searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: sendory,
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      searchcontroller.clear();
                      searchsongs = listall;
                      BlocProvider.of<SearchBloc>(context)
                          .add(SearchingSongEvent(searchsongs));
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      FontAwesomeIcons.chevronLeft,
                      color: primary,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text(
                      'Search Songs Here',
                      style: TextStyle(
                        color: primary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.010,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    height: height * 0.08,
                    width: 300,
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      controller: searchcontroller,
                      onChanged: (value) => search(value, context),
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            FontAwesomeIcons.magnifyingGlass,
                            size: 17,
                            color: Colors.white,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              searchcontroller.clear();
                              searchsongs = listall;
                              BlocProvider.of<SearchBloc>(context)
                                  .add(SearchingSongEvent(searchsongs));
                            },
                            icon: Icon(
                              Icons.clear,
                              color: sendory,
                            ),
                          ),
                          hintText: 'search',
                          hintStyle: const TextStyle(color: Colors.white),
                          border: InputBorder.none),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      color: primary),
                  child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      return state.searchedsongs.isEmpty
                          ? Center(
                              child: ListView(
                                children: [
                                  Lottie.asset('assets/search-not-found.json'),
                                  Center(
                                    child: Text(
                                      'No Songs Found',
                                      style: TextStyle(
                                          color: sendory,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.separated(
                              itemBuilder: (context, index) {
                                // Songs song = state.searchedsongs[index];
                                return ListTile(
                                    onTap: () {
                                      Songs song = state.searchedsongs[index];
                                      int songidx = 0;
                                      for (int i = 0; i < listall.length; i++) {
                                        if (song.id == listall[i].id) {
                                          songidx = i;
                                        }
                                      }
                                      playAudio(listall, songidx);
                                    },
                                    title: Text(
                                      state.searchedsongs[index].songname!,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      state.searchedsongs[index].artist!,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    leading: CircleAvatar(
                                        backgroundColor: sendory,
                                        child: QueryArtworkWidget(
                                          id: state.searchedsongs[index].id!,
                                          type: ArtworkType.AUDIO,
                                          nullArtworkWidget: Image.asset(
                                              'assets/images/Retro_cassette_tape_vector-removebg-preview (2).png'),
                                        )),
                                    trailing: Popupmenu(
                                        favicon: Icons.favorite_border,
                                        height: height,
                                        idx: index,
                                        songs: searchsongs));
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
                              itemCount: searchsongs.length);
                    },
                  ),
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: MiniPlayer(),
            ),
          )
        ],
      )),
    );
  }

  search(String value, BuildContext context) {
    searchsongs = dbsongs
        .where((element) => element.songname!
            .toLowerCase()
            .contains(value.toLowerCase().trim()))
        .toList();
    // allSongs.clear();

    BlocProvider.of<SearchBloc>(context).add(SearchingSongEvent(searchsongs));
  }
}
