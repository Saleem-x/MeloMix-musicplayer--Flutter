part of 'playerscreen_bloc.dart';

@immutable
abstract class PlayerscreenEvent {}

class LoadingEvent extends PlayerscreenEvent {
  final bool isLoading;

  LoadingEvent(this.isLoading);
}
