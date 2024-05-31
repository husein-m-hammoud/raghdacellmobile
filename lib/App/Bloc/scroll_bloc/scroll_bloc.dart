import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

part 'scroll_event.dart';
part 'scroll_state.dart';

class ScrollBloc extends Bloc<ScrollEvent, ScrollListener> {
  ScrollController scrollControllerHome = ScrollController();
  ScrollController scrollControllerProduct = ScrollController();

  bool showAppBar = true;

  ScrollBloc() : super(ScrollListener()) {
    on<ShowAppBarHome>((event, emit) {
      if (scrollControllerHome.position.userScrollDirection ==
          ScrollDirection.forward) {
        showAppBar = true;
        emit(ScrollListener());
      } else if (scrollControllerHome.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showAppBar = false;
        emit(ScrollListener());
      }
    });

    on<ShowAppBarProduct>((event, emit) {
      if (scrollControllerProduct.position.userScrollDirection ==
          ScrollDirection.forward) {
        showAppBar = true;
        emit(ScrollListener());
      } else if (scrollControllerProduct.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showAppBar = false;
        emit(ScrollListener());
      }
    });
    scrollControllerProduct.addListener(() => add(ShowAppBarProduct()));

    scrollControllerHome.addListener(
      () => add(ShowAppBarHome()),
    );
  }
}
