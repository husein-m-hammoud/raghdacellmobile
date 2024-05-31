import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:raghadcell/Apis/ExceptionsHandle.dart';
import 'package:raghadcell/Apis/Network.dart';
import 'package:raghadcell/Apis/Urls.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/models/about_us_model.dart';

part 'about_us_event.dart';
part 'about_us_state.dart';

class AboutUsBloc extends Bloc<AboutUsEvent, AboutUsState> {
  AboutUsBloc() : super(AboutUsLoadingState()) {
    on<AboutUsEvent>((event, emit) async {
      emit(AboutUsLoadingState());
      try {
        final response = await Network.getData(url: Urls.aboutUs);
        AboutUsModel aboutUsModel = AboutUsModel.fromJson(response.data);

        emit(GetAboutUsState(aboutUsModel: aboutUsModel));
      } catch (error) {
        if (error is DioException) {
          emit(AboutUsErrorState(message: exceptionsHandle(error: error)));
        } else {
          emit(AboutUsErrorState(message: error.toString()));
        }
      }
    });
  }
}
