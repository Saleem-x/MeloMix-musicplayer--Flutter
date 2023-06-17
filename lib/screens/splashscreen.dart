import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/bloc/splashscreenbloc/splashscreen_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../db/models/db_model.dart';
import '../materials/material.dart';

final audioQuery = OnAudioQuery();
final box = SongBox.getInstance();
List<SongModel> allSongs = [];
// ignore: constant_identifier_names
const Save_Key = 'userLoggedin';

// class SplasScreen extends StatefulWidget {
//   const SplasScreen({super.key});

//   @override
//   State<SplasScreen> createState() => _SplasScreenState();
// }

// class _SplasScreenState extends State<SplasScreen> {

// }
// ignore: must_be_immutable
class SplasScreen extends StatelessWidget {
  SplasScreen({super.key});

  List<SongModel> fetchSongs = [];

  List<Audio> fullsongs = [];

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SplashscreenBloc>(context)
        .add(CheckPermissionEvent(fetchsongs: fetchSongs));
    BlocProvider.of<SplashscreenBloc>(context)
        .add(CheckLoginEvent(context: context, userin: Save_Key));
    return Scaffold(
        backgroundColor: sendory,
        body: Image.asset('assets/images/loading_screen.jpg'));
  }
}
//  @override
//   void initState() {
//     // requestStoragePermission();
//     // checkLogin();
//     super.initState();
  // }
  // Future<void> getStarted() async {
  //   // ignore: use_build_context_synchronously
  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return const IntroScreen();
  //   }));
  // }

  // Future<void> checkLogin() async {
  //   await Future.delayed(const Duration(seconds: 3));
  //   final sharedprefs = await SharedPreferences.getInstance();
  //   final userin = sharedprefs.getBool(Save_Key);
  //   if (userin == null || userin == false) {
  //     getStarted();
  //   } else {
  //     // ignore: use_build_context_synchronously
  //     Navigator.of(context)
  //         .pushReplacement(MaterialPageRoute(builder: (context1) {
  //       return HomeScreen();
  //     }));
  //   }
  // }

  // requestStoragePermission() async {
  //   bool permissionStatus = await audioQuery.permissionsStatus();
  //   if (!permissionStatus) {
  //     await audioQuery.permissionsRequest();

  //     fetchSongs = await audioQuery.querySongs();

  //     for (var element in fetchSongs) {
  //       if (element.fileExtension == "mp3") {
  //         allSongs.add(element);
  //       }
  //     }

  //     // ignore: avoid_function_literals_in_foreach_calls
  //     allSongs.forEach((element) {
  //       box.add(Songs(
  //           songname: element.title,
  //           artist: element.artist,
  //           duration: element.duration,
  //           id: element.id,
  //           songurl: element.uri));
  //     });
  //     if (mostplayedsongs.isEmpty) {
  //       for (var element in allSongs) {
  //         mostplayedsongs.add(MostPlayed(
  //             songname: element.title,
  //             artist: element.artist!,
  //             duration: element.duration!,
  //             songurl: element.uri!,
  //             count: 0,
  //             id: element.id));
  //       }
  //     }
  //   }
  //   setState(() {});
  // }
// }
