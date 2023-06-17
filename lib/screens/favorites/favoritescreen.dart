import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/bloc/favorite/favorite_bloc.dart';
import 'package:music_player/db/functions/db_functions.dart';
import 'package:music_player/screens/favorites/favoriteslist.dart';
import '../../materials/material.dart';
import '../miniplayer/miniplayer.dart';

// ignore: must_be_immutable
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    BlocProvider.of<FavoriteBloc>(context)
        .add(FavoriteSongsListEvent(favsongbox: favsongbox));
    return Scaffold(
      backgroundColor: sendory,
      body: SafeArea(
          child: Column(
        children: [
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
                    'Favorite Songs',
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Row(children: [
              SizedBox(
                height: 30,
              ),
            ]),
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
                  child: const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Favoriteslist()),
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
        ],
      )),
    );
  }
}
