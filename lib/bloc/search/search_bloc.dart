import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_player/db/models/db_model.dart';
import 'package:music_player/screens/searchscreen/searchwidget.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial(listall)) {
    on<SearchingSongEvent>((event, emit) {
      emit(SearchState(event.searchedsongs));
    });
  }
}
