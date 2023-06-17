part of 'splashscreen_bloc.dart';

@immutable
abstract class SplashscreenEvent {}

class CheckLoginEvent extends SplashscreenEvent {
  final String userin;
  final BuildContext context;

  CheckLoginEvent({required this.context, required this.userin});
}

// ignore: must_be_immutable
class CheckPermissionEvent extends SplashscreenEvent {
  List<SongModel> fetchsongs;

  CheckPermissionEvent({required this.fetchsongs});
}
