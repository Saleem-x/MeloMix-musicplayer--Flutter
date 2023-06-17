import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:music_player/db/functions/db_functions.dart';
import 'package:music_player/db/models/db_model.dart';
import 'package:music_player/db/models/mostplayedmodel/mostplayed.dart';
import 'package:music_player/screens/homescreen/homescreen.dart';
import 'package:music_player/screens/introscreen.dart';
import 'package:music_player/screens/splashscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splashscreen_event.dart';
part 'splashscreen_state.dart';

class SplashscreenBloc extends Bloc<SplashscreenEvent, SplashscreenState> {
  SplashscreenBloc() : super(SplashscreenInitial(Save_Key)) {
    on<CheckLoginEvent>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userin = prefs.getBool(Save_Key);
      if (userin == null || userin == false) {
        await Future.delayed(const Duration(seconds: 3));
        // ignore: use_build_context_synchronously
        Navigator.push(event.context, MaterialPageRoute(builder: (context) {
          return const IntroScreen();
        }));
      } else {
        await Future.delayed(const Duration(seconds: 3));
        // ignore: use_build_context_synchronously
        Navigator.of(event.context)
            .pushReplacement(MaterialPageRoute(builder: (context1) {
          return HomeScreen();
        }));
      }
    });
    on<CheckPermissionEvent>((event, emit) async {
      bool permissionStatus = await audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await audioQuery.permissionsRequest();

        event.fetchsongs = await audioQuery.querySongs();

        for (var element in event.fetchsongs) {
          if (element.fileExtension == "mp3") {
            allSongs.add(element);
          }
        }

        // ignore: avoid_function_literals_in_foreach_calls
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
    });
  }
}
