import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/materials/material.dart';
import 'package:music_player/screens/albums/albumsongs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ListAlbums extends StatefulWidget {
  List<AlbumModel> albums;
  ListAlbums({super.key, required this.albums});

  @override
  State<ListAlbums> createState() => _ListAlbumsState();
}

class _ListAlbumsState extends State<ListAlbums> {
  // final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
      child: widget.albums.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/common-empty.json'),
                  Text(
                    'No Playlist available',
                    style: GoogleFonts.play(fontSize: 17, color: primary),
                  ),
                ],
              ),
            )
          : GridView.builder(
              itemCount: widget.albums.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return AlbumSongs(
                          albums: widget.albums[index],
                        );
                      },
                    ));
                  },
                  child: Card(
                      color: sendory,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 120,
                            child: Center(
                              child: Image.asset(
                                'assets/images/Retro_cassette_tape_vector-removebg-preview (2).png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30)),
                                color: primary,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  widget.albums[index].album,
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                );
              },
            ),
    );
  }
}
