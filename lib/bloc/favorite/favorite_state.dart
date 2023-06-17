part of 'favorite_bloc.dart';

class FavoriteState {
  final Box<Favsongs> favsongbox;
  FavoriteState(this.favsongbox);
}

class FavoriteInitial extends FavoriteState {
  FavoriteInitial(super.favsongbox);
}
