import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/functions/db_functions.dart';
import 'package:music_player/db/models/db_model.dart';
import 'package:music_player/db/models/favoritesmodel/favoritesmodel.dart';
import 'package:music_player/db/models/playlismodel/playlistmodel.dart';
import 'package:music_player/db/models/recentmodel/recentmodel.dart';
import 'package:music_player/screens/splashscreen.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'db/models/mostplayedmodel/mostplayed.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // ignore: unused_local_variable
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  Hive.registerAdapter(SongsAdapter());
  await Hive.openBox<Songs>('Songs');
  Hive.registerAdapter(RecentlyPlayedAdapter());
  openrecentlyplayeddb();
  Hive.registerAdapter((PlaylistsongsAdapter()));
  openplaylistdb();
  Hive.registerAdapter(FavsongsAdapter());
  openfavdb();
  Hive.registerAdapter(MostPlayedAdapter());
  openmostpllayeddb();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const SplasScreen(),
    );
  }
}
