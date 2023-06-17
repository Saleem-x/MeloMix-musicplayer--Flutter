part of 'allsongs_bloc.dart';

@immutable
abstract class AllsongsEvent {}

class GetAllSongs extends AllsongsEvent {
  final Box<Songs> allsongs;

  GetAllSongs({required this.allsongs});
}
