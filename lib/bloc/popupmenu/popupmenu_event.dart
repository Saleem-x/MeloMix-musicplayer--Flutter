part of 'popupmenu_bloc.dart';

@immutable
abstract class PopupmenuEvent {}

class AddtoFavEvent extends PopupmenuEvent {
  final Box<Favsongs> favoritesongs;

  AddtoFavEvent({required this.favoritesongs});
}

class RemoveFavEvent extends PopupmenuEvent {
  final Favsongs favsong;

  RemoveFavEvent({required this.favsong});
}

class AddfavEvent extends PopupmenuEvent {
  final Favsongs favsong;

  AddfavEvent({required this.favsong});
}
