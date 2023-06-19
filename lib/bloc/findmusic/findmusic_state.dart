part of 'findmusic_bloc.dart';

class FindmusicState {
  final ACRCloudResponseMusicItem? music;

  FindmusicState(this.music);
}

class FindmusicInitial extends FindmusicState {
  FindmusicInitial(super.music);
}
