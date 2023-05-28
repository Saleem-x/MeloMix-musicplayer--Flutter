import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:music_player/db/functions/db_functions.dart';
import 'package:music_player/db/models/db_model.dart';
import 'package:music_player/db/models/favoritesmodel/favoritesmodel.dart';
import 'package:music_player/db/models/mostplayedmodel/mostplayed.dart';
import '../../screens/homescreen/homescreen.dart';
import '../models/recentmodel/recentmodel.dart';

playAudio(List<Songs> songs, int index) async {
  for (var item in songs) {
    playinglistAudio.add(Audio.file(item.songurl!,
        metas: Metas(
            image: const MetasImage.asset('path'),
            title: item.songname,
            artist: item.artist,
            id: item.id.toString())));
    var k = addtorec(songs[index]);
    updaterecentlyplayed(k);
  }
  player.open(
    Playlist(audios: playinglistAudio, startIndex: index),
    showNotification: true,
    headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
    notificationSettings: const NotificationSettings(stopEnabled: true),
  );
}

RecentlyPlayed addtorec(Songs songs) {
  return RecentlyPlayed(
      id: songs.id,
      songname: songs.songname,
      artist: songs.artist,
      songurl: songs.songurl,
      duration: songs.duration);
}

playfavAudios(List<Favsongs> songs, int index) async {
  currentfavlist.clear();
  for (var item in songs) {
    currentfavlist.add(Audio.file(item.songurl!,
        metas: Metas(
            image: const MetasImage.asset('path'),
            title: item.songname,
            artist: item.artist,
            id: item.id.toString())));
  }
  player.open(
    Playlist(audios: currentfavlist, startIndex: index),
    showNotification: true,
    notificationSettings: const NotificationSettings(stopEnabled: false),
  );
  addtorec2(songs[index]);
}

RecentlyPlayed addtorec2(Favsongs songs) {
  return RecentlyPlayed(
      id: songs.id,
      songname: songs.songname,
      artist: songs.artist,
      songurl: songs.songurl,
      duration: songs.duration);
}

playlistAudios(List<Songs> songs, int index) async {
  currentplaylist.clear();
  for (var item in songs) {
    currentplaylist.add(Audio.file(item.songurl!,
        metas: Metas(
            image: const MetasImage.asset('path'),
            title: item.songname,
            artist: item.artist,
            id: item.id.toString())));
  }
  player.open(
    Playlist(audios: currentplaylist, startIndex: index),
    showNotification: true,
    notificationSettings: const NotificationSettings(stopEnabled: true),
  );
  addtorec(songs[index]);
}

playmostplayed(List<MostPlayed> songs, int index) async {
  mostplay.clear();
  for (var item in songs) {
    mostplay.add(Audio.file(item.songurl,
        metas: Metas(
            image: const MetasImage.asset('path'),
            title: item.songname,
            artist: item.artist,
            id: item.id.toString())));
  }
  player.open(
    Playlist(audios: mostplay, startIndex: index),
    showNotification: true,
    notificationSettings: const NotificationSettings(stopEnabled: true),
  );
}
