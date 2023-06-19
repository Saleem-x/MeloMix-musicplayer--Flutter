import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:music_player/db/functions/db_functions.dart';
import 'package:music_player/db/models/mostplayedmodel/mostplayed.dart';

part 'mostplayed_event.dart';
part 'mostplayed_state.dart';

class MostplayedBloc extends Bloc<MostplayedEvent, MostplayedState> {
  MostplayedBloc() : super(MostplayedInitial(mostplayedsongs)) {
    on<GetAllMPSongsEvent>((event, emit) {
      emit(MostplayedState(event.mostplayedsongs));
    });
  }
}
