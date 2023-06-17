import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:music_player/db/functions/db_functions.dart';
import 'package:music_player/db/models/recentmodel/recentmodel.dart';

part 'recentscreen_event.dart';
part 'recentscreen_state.dart';

class RecentscreenBloc extends Bloc<RecentscreenEvent, RecentscreenState> {
  RecentscreenBloc() : super(RecentscreenInitial(recentlyplayedbox)) {
    on<UpdateRecentEvent>((event, emit) {
      emit(RecentscreenState(event.recentbox));
    });
  }
}
