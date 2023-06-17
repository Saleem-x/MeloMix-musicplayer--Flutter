part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {}

class FavoriteSongsListEvent extends FavoriteEvent {
  final Box<Favsongs> favsongbox;
  FavoriteSongsListEvent({required this.favsongbox});
}
