import 'package:genius_lyrics/genius_lyrics.dart';
import 'dart:developer';

String? lyrics;
Genius genius = Genius(
    accessToken:
        'Zp1v9U7kuNpqKy8SkLMHKx7m6tOx1U8vOs6U4Jk9BSdsrgp7wOrMBmg3cvRnhrrP');
printlyrics(String songname, String artist) async {
  Song? song = (await genius.searchSong(artist: artist, title: songname));
  if (song != null) {
    log(song.lyrics.toString());
    lyrics = song.lyrics ?? 'No Lyrics available for this songs';
  }
}
