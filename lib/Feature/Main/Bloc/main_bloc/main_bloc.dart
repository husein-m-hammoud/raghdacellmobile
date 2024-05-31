import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, BottomNavigationBarState> {
  bool showBottomNavigationBar = true;
  int currentIndex = 0;
  MainBloc() : super(BottomNavigationBarState()) {
    on<HideBottomNavigationBar>((event, emit) {
      showBottomNavigationBar = false;
      emit(BottomNavigationBarState());
    });
    on<ShowBottomNavigationBar>((event, emit) {
      showBottomNavigationBar = true;
      emit(BottomNavigationBarState());
    });
    on<SelectBottomNavigationBarItem>((event, emit) {
      currentIndex = event.index;
      emit(BottomNavigationBarState());
    });
  }
}
