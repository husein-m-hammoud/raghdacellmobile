import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:raghadcell/App/app.dart';

part 'current_page_event.dart';
part 'current_page_state.dart';

class ChangePageColorBloc extends Bloc<ChangePageColorEvent, ChangePageColorState> {
  PagesEnum currentPage = PagesEnum.homePage;
  ChangePageColorBloc() : super(ChangePageColorInitial()) {
    on<ChangePageColorEvent>((event, emit) {
      currentPage = event.currentPage;
      emit(ChangePageColorState());
    });
  }
}
