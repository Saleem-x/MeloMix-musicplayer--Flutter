import 'package:genius_lyrics/genius_lyrics.dart';
import 'dart:developer';

String? Lyrics;
Genius genius = Genius(
    accessToken:
        'Zp1v9U7kuNpqKy8SkLMHKx7m6tOx1U8vOs6U4Jk9BSdsrgp7wOrMBmg3cvRnhrrP');
printlyrics(String songname, String artist) async {
  // Lyrics = null;
  Song? song = (await genius.searchSong(artist: artist, title: songname));
  if (song != null) {
    // print(song.lyrics);
    log(song.lyrics.toString());
    Lyrics = song.lyrics ?? 'No Lyrics available for this songs';
  }
}
