part of 'findmusic_bloc.dart';

@immutable
abstract class FindmusicEvent {}

class GetMusicEvent extends FindmusicEvent {
  final ACRCloudResponseMusicItem? music;

  GetMusicEvent({required this.music});
}

class AcrCloudSetUp extends FindmusicEvent {}
