part of 'mostplayed_bloc.dart';

@immutable
abstract class MostplayedEvent {}

class GetAllMPSongsEvent extends MostplayedEvent {
  final Box<MostPlayed> mostplayedsongs;

  GetAllMPSongsEvent({required this.mostplayedsongs});
}
