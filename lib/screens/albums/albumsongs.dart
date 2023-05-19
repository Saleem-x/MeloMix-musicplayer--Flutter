import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/screens/homescreen/homescreen.dart';
import 'package:music_player/screens/miniplayer/miniplayer.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../materials/material.dart';

class AlbumSongs extends StatefulWidget {
  AlbumModel albums;
  AlbumSongs({
    super.key,
    required this.albums,
  });

  @override
  State<AlbumSongs> createState() => _AlbumSongsState();
}

class _AlbumSongsState extends State<AlbumSongs> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  List<SongModel> songsInAlbum = [];
  List<Audio> albumsongs = [];
  ValueNotifier<List<SongModel>> songstolist =
      ValueNotifier<List<SongModel>>([]);
  fetchsongs() async {
    List<SongModel> allSongs = await _audioQuery.querySongs();
    songstolist.value =
        allSongs.where((song) => song.albumId == widget.albums.id).toList();
  }

  @override
  void initState() {
    fetchsongs();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

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
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
                height: height * 0.05,
                width: width * 0.8,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    widget.albums.album,
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
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
                      topLeft: Radius.circular(60),
                    ),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: ValueListenableBuilder(
                        valueListenable: songstolist,
                        builder: (context, value, child) {
                          return ListView.separated(
                              itemBuilder: (context, index) {
                                SongModel song = value[index];
                                return ListTile(
                                  onTap: () {
                                    albumsongs.clear();
                                    for (var item in value) {
                                      albumsongs.add(Audio.file(song.uri!,
                                          metas: Metas(
                                            image: MetasImage.file(
                                              QueryArtworkWidget(
                                                id: item.id,
                                                type: ArtworkType.AUDIO,
                                                nullArtworkWidget: Image.asset(
                                                    'assets/images/Retro_cassette_tape_vector-removebg-preview (2).png'),
                                              ).toString(),
                                            ),
                                            title: item.title,
                                            artist: item.artist,
                                            id: item.id.toString(),
                                          )));
                                    }
                                    player.open(Playlist(
                                        audios: albumsongs, startIndex: index));
                                  },
                                  title: Text(
                                    song.displayNameWOExt,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.play(
                                      color: Colors.white,
                                    ),
                                  ),
                                  subtitle: SingleChildScrollView(
                                    child: Text(
                                      song.artist!
                                          .toUpperCase()
                                          .toLowerCase()
                                          .replaceAll('?', ''),
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.play(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundColor: sendory,
                                    child: ClipOval(
                                      child: QueryArtworkWidget(
                                        id: 0,
                                        type: ArtworkType.AUDIO,
                                        nullArtworkWidget: Image.asset(
                                            'assets/images/Retro_cassette_tape_vector-removebg-preview (2).png'),
                                      ),
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
                              itemCount: songstolist.value.length);
                        },
                      )),
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
          ),
        ]),
      ),
    );
  }
}
