import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'playerscreen_event.dart';
part 'playerscreen_state.dart';

class PlayerscreenBloc extends Bloc<PlayerscreenEvent, PlayerscreenState> {
  PlayerscreenBloc() : super(PlayerscreenInitial(false)) {
    on<LoadingEvent>((event, emit) {
      emit(PlayerscreenState(event.isLoading));
    });
  }
}
