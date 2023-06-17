part of 'recentscreen_bloc.dart';

class RecentscreenState {
  final Box<RecentlyPlayed> recentbox;

  RecentscreenState(this.recentbox);
}

class RecentscreenInitial extends RecentscreenState {
  RecentscreenInitial(super.recentbox);
}
