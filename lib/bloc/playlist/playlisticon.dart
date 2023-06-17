import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IconCubit extends Cubit<IconData> {
  IconCubit() : super(Icons.add_circle);

  void add() => emit(Icons.add_circle);
  void remove() => emit(Icons.remove_circle);
}
