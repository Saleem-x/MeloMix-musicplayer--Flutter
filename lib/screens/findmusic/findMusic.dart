// ignore_for_file: file_names
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/bloc/findmusic/findmusic_bloc.dart';
import 'package:music_player/screens/findmusic/cardwidget.dart';
import '../../materials/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter_acrcloud/flutter_acrcloud.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class FindMusic extends StatelessWidget {
  FindMusic({super.key});

  ACRCloudResponseMusicItem? music;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FindmusicBloc>(context).add(GetMusicEvent(music: null));
    });
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
                    'Find Music',
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
            height: 20,
          ),
          Expanded(
              child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(60),
              ),
            ),
            child: BlocBuilder<FindmusicBloc, FindmusicState>(
              builder: (context, state) {
                return Column(children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  AvatarGlow(
                    endRadius: 100,
                    child: GestureDetector(
                      onTap: () async {
                        BlocProvider.of<FindmusicBloc>(context)
                            .add(GetMusicEvent(music: null));
                        final session = ACRCloud.startSession();
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                            backgroundColor: primary,
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Lottie.asset('assets/searchanim.json'),
                                Text(
                                  'Searching for the Song',
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    session.cancel();
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.white),
                                  ))
                            ],
                          ),
                        );

                        final result = await session.result;
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                        if (result == null) {
                          return;
                        } else if (result.metadata == null) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('No result.'),
                          ));
                          return;
                        }
                        // ignore: use_build_context_synchronously
                        BlocProvider.of<FindmusicBloc>(context).add(
                            GetMusicEvent(music: result.metadata!.music.first));
                      },
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: primary,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 1.5,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                                inset: true,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.radar,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  state.music == null
                      ? Container(
                          height: 200,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 1.5,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                                inset: true,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'tap the circle',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      : SongCard(
                          songName: state.music!.title,
                          artistName: state.music!.artists.first.name,
                          album: state.music!.album.name,
                          imageUrl:
                              'assets/images/Retro_cassette_tape_vector-removebg-preview (2).png')
                ]);
              },
            ),
          )),
        ]),
      ),
    );
  }
}
