import 'package:hive_flutter/adapters.dart';
import '../db_model.dart';
part 'playlistmodel.g.dart';

@HiveType(typeId: 3)
class Playlistsongs {
  @HiveField(0)
  String playlistname;
  @HiveField(1)
  List<Songs>? playlistsongs;

  Playlistsongs({required this.playlistname, required this.playlistsongs});
}
