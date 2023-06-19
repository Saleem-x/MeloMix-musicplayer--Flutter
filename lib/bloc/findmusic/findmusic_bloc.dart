import 'package:bloc/bloc.dart';
import 'package:flutter_acrcloud/flutter_acrcloud.dart';
import 'package:meta/meta.dart';

part 'findmusic_event.dart';
part 'findmusic_state.dart';

class FindmusicBloc extends Bloc<FindmusicEvent, FindmusicState> {
  FindmusicBloc() : super(FindmusicInitial(null)) {
    on<GetMusicEvent>((event, emit) {
      ACRCloud.setUp(const ACRCloudConfig(
          'f7e680a066a887f0c15fc5121e5d237c',
          'zYbI3Yz9uc2sV0MHKE5XbgyoB4A2IZ7DmkapWwqJ',
          'identify-ap-southeast-1.acrcloud.com'));
      emit(FindmusicState(event.music));
    });
  }
}
