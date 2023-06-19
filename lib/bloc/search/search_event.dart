part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchingSongEvent extends SearchEvent {
  final List<Songs> searchedsongs;

  SearchingSongEvent(this.searchedsongs);
}
