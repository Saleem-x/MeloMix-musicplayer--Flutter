import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/db/functions/db_functions.dart';
import 'package:music_player/db/models/mostplayedmodel/mostplayed.dart';
import 'package:music_player/screens/getstarted.dart';
import 'package:music_player/screens/homescreen/homescreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/models/db_model.dart';
import '../materials/material.dart';

List<SongModel> allSongs = [];
// ignore: constant_identifier_names
const Save_Key = 'userLoggedin';

class SplasScreen extends StatefulWidget {
  const SplasScreen({super.key});

  @override
  State<SplasScreen> createState() => _SplasScreenState();
}

class _SplasScreenState extends State<SplasScreen> {
  final audioQuery = OnAudioQuery();
  final box = SongBox.getInstance();
  List<SongModel> fetchSongs = [];

  List<Audio> fullsongs = [];
  @override
  void initState() {
    requestStoragePermission();
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: sendory,
        body: Image.asset('assets/images/loading_screen.jpg'));
  }

  Future<void> getStarted() async {
    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const GetStarted();
    }));
  }

  Future<void> checkLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    final sharedprefs = await SharedPreferences.getInstance();
    final userin = sharedprefs.getBool(Save_Key);
    if (userin == null || userin == false) {
      getStarted();
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context1) {
        return HomeScreen();
      }));
    }
  }

  requestStoragePermission() async {
    bool permissionStatus = await audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await audioQuery.permissionsRequest();

      fetchSongs = await audioQuery.querySongs();

      for (var element in fetchSongs) {
        if (element.fileExtension == "mp3") {
          allSongs.add(element);
        }
      }

      allSongs.forEach((element) {
        box.add(Songs(
            songname: element.title,
            artist: element.artist,
            duration: element.duration,
            id: element.id,
            songurl: element.uri));
      });
      if (mostplayedsongs.isEmpty) {
        for (var element in allSongs) {
          mostplayedsongs.add(MostPlayed(
              songname: element.title,
              artist: element.artist!,
              duration: element.duration!,
              songurl: element.uri!,
              count: 0,
              id: element.id));
        }
      }
    }
    setState(() {});
  }
}
