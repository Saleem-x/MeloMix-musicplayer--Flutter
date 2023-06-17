import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/bloc/favorite/favorite_bloc.dart';
import 'package:music_player/bloc/popupmenu/popupmenu_bloc.dart';
import 'package:music_player/db/functions/db_functions.dart';
import 'package:music_player/db/functions/playerfunctions.dart';
import 'package:music_player/db/models/favoritesmodel/favoritesmodel.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../materials/material.dart';

ValueNotifier<List<Favsongs>> favoritelistener =
    ValueNotifier(favsongbox.values.toList());

class Favoriteslist extends StatelessWidget {
  const Favoriteslist({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        List<Favsongs> allsongs = state.favsongbox.values.toList();
        return state.favsongbox.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/common-empty.json'),
                    Text(
                      'No Favorite Songs available',
                      style: TextStyle(
                          color: sendory,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            : ListView.separated(
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
                              favsongbox.deleteAt(index);
                              BlocProvider.of<PopupmenuBloc>(context).add(
                                  AddtoFavEvent(favoritesongs: favsongbox));
                              BlocProvider.of<FavoriteBloc>(context).add(
                                  FavoriteSongsListEvent(
                                      favsongbox: favsongbox));
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
                                          width: size.width * 0.01,
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


//  if (favsongbox.values.isEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Lottie.asset('assets/common-empty.json'),
//                 Text(
//                   'No Favorite Songs available',
//                   style: TextStyle(
//                       color: sendory,
//                       fontSize: 17,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           );
//         }