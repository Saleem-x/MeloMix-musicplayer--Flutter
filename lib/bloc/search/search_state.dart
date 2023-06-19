part of 'search_bloc.dart';

class SearchState {
  final List<Songs> searchedsongs;

  SearchState(this.searchedsongs);
}

class SearchInitial extends SearchState {
  SearchInitial(super.searchedsongs);
}
