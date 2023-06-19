// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:music_player/db/models/db_model.dart';

// class IconCubit extends Cubit<List<Songs>> {
//   IconCubit() : super();

//   void add(Songs songs) {

//   }
//   void remove() => emit();
// }
import 'package:flutter_bloc/flutter_bloc.dart';

enum IconState { addCircle, removeCircle }

class IconCubit extends Cubit<IconState> {
  IconCubit() : super(IconState.addCircle);

  void toggleIcon() {
    emit(state == IconState.addCircle
        ? IconState.removeCircle
        : IconState.addCircle);
  }
}
