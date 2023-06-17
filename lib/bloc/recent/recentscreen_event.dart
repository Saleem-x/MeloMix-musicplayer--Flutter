part of 'recentscreen_bloc.dart';

@immutable
abstract class RecentscreenEvent {}

class UpdateRecentEvent extends RecentscreenEvent {
  final Box<RecentlyPlayed> recentbox;

  UpdateRecentEvent({required this.recentbox});
}
