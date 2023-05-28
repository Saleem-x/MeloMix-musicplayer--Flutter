import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/db/functions/db_functions.dart';
import 'package:music_player/db/functions/playerfunctions.dart';
import 'package:music_player/db/models/favoritesmodel/favoritesmodel.dart';
import 'package:music_player/screens/homescreen/homescreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../materials/material.dart';

ValueNotifier<List<Favsongs>> favoritelistener =
    ValueNotifier(favsongbox.values.toList());

class Favoriteslist extends StatefulWidget {
  const Favoriteslist({super.key});

  @override
  State<Favoriteslist> createState() => _FavoriteslistState();
}

class _FavoriteslistState extends State<Favoriteslist> {
  @override
  void initState() {
    final favsongsdb = favsongbox.values.toList();
    for (var item in favsongsdb) {
      currentfavlist.add(Audio.file(item.songurl.toString(),
          metas: Metas(
              artist: item.artist,
              title: item.songname,
              id: item.id.toString())));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return ValueListenableBuilder<Box<Favsongs>>(
      valueListenable: favsongbox.listenable(),
      builder: (context, Box<Favsongs> favsongslist, child) {
        List<Favsongs> allsongs = favsongslist.values.toList();
        if (favsongbox.values.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/search-not-found.json'),
                Text(
                  'No Favorite Songs available',
                  style: TextStyle(
                      color: sendory,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }
        return ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                  onTap: () {
                    playfavAudios(allsongs, index);
                  },
                  title: Text(
                    allsongs[index].songname!,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.play(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    allsongs[index].artist!,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.play(
                      color: Colors.white,
                    ),
                  ),
                  leading: CircleAvatar(
                      backgroundColor: sendory,
                      child: QueryArtworkWidget(
                          id: allsongs[index].id!,
                          nullArtworkWidget: Image.asset(
                              'assets/images/Retro_cassette_tape_vector-removebg-preview (2).png'),
                          type: ArtworkType.AUDIO)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            favsongslist.deleteAt(index);
                          });
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                backgroundColor: primary,
                                content: Row(
                                  children: [
                                    Text(
                                      'song removed from favorites',
                                      style: GoogleFonts.play(
                                        fontSize: 17,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.01,
                                    ),
                                    Icon(
                                      Icons.info,
                                      color: sendory,
                                    )
                                  ],
                                ),
                              ),
                            );
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ));
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
            itemCount: allsongs.length);
      },
    );
  }
}
