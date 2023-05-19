import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/db/models/db_model.dart';
import 'package:music_player/screens/searchscreen/searchwidget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../screens/homescreen/homescreen.dart';

playAudio(List<Songs> songs, int index) async {
  for (var item in songs) {
    playinglistAudio.add(Audio.file(
      item.songurl!,
      metas: Metas(
        image: MetasImage.file(
          QueryArtworkWidget(
            id: item.id!,
            type: ArtworkType.AUDIO,
            nullArtworkWidget: Image.asset(
                'assets/images/Retro_cassette_tape_vector-removebg-preview (2).png'),
          ).toString(),
        ),
        title: item.songname,
        artist: item.artist,
        id: item.id.toString(),
      ),
    ));
  }
  player.open(
      Playlist(
        audios: playinglistAudio,
        startIndex: index,
      ),
      showNotification: true,
      headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
      notificationSettings: const NotificationSettings(
          stopEnabled: true,
          nextEnabled: true,
          prevEnabled: true,
          playPauseEnabled: true));
}

findcurretsongs(int? id) {
  for (Songs song in listall) {
    if (song.id == id) {
      currentlyplaying = song;
      break;
    }
  }
}
