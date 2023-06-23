import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/bloc/albums/albums_bloc.dart';
import 'package:music_player/bloc/allsongs/allsongs_bloc.dart';
import 'package:music_player/bloc/currentplaying/playerscreen_bloc.dart';
import 'package:music_player/bloc/favorite/favorite_bloc.dart';
import 'package:music_player/bloc/findmusic/findmusic_bloc.dart';
import 'package:music_player/bloc/mostplayed/mostplayed_bloc.dart';
import 'package:music_player/bloc/playlist/playlist_bloc.dart';
import 'package:music_player/bloc/popupmenu/popupmenu_bloc.dart';
import 'package:music_player/bloc/recent/recentscreen_bloc.dart';
import 'package:music_player/bloc/search/search_bloc.dart';
import 'package:music_player/bloc/splashscreenbloc/splashscreen_bloc.dart';
import 'package:music_player/bloc/theme/theme_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashscreenBloc>(
          create: (context) => SplashscreenBloc(),
        ),
        BlocProvider<RecentscreenBloc>(
          create: (context) => RecentscreenBloc(),
        ),
        BlocProvider<PopupmenuBloc>(
          create: (context) => PopupmenuBloc(),
        ),
        BlocProvider<AllsongsBloc>(
          create: (context) => AllsongsBloc(),
        ),
        BlocProvider<PlaylistBloc>(
          create: (context) => PlaylistBloc(),
        ),
        BlocProvider<FavoriteBloc>(
          create: (context) => FavoriteBloc(),
        ),
        // BlocProvider<IconCubit>(
        //   create: (context) => IconCubit(),
        // ),
        BlocProvider<MostplayedBloc>(
          create: (context) => MostplayedBloc(),
        ),
        BlocProvider<FindmusicBloc>(
          create: (context) => FindmusicBloc(),
        ),
        BlocProvider<AlbumsBloc>(
          create: (context) => AlbumsBloc(),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(),
        ),
        BlocProvider<PlayerscreenBloc>(
          create: (context) => PlayerscreenBloc(),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: SplasScreen(),
      ),
    );
  }
}
