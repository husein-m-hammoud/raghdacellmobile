import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';

import '../../../Apis/Network.dart';
import '../../../Apis/Urls.dart';

part 'app_language_event.dart';
part 'app_language_state.dart';

class AppLanguageBloc extends Bloc<AppLanguageEvent, LanguageState> {
  AppLanguageBloc()
      : super(InitialLanguageState(locale: Locale(AppSharedPreferences.getArLang))) {
    on<AppLanguageEvent>((event, emit) async {
      try {
        if (event is InitLanguage) {
          emit(InitialLanguageState(locale: Locale(AppSharedPreferences.getArLang)));
        }
        if (event is ChangeLanguageToAr) {
          emit(LanguageLoadingState());
          await AppSharedPreferences.saveArLang('ar');
          await Network.postData(
              url: '${Urls.baseUrl}/change/locale', data: {'locale': 'ar'});
          emit(ChangLanguageState(locale: Locale(AppSharedPreferences.getArLang)));
        }
        if (event is ChangeLanguageToEn) {
          emit(LanguageLoadingState());
          await Network.postData(
              url: '${Urls.baseUrl}/change/locale', data: {'locale': 'en'});
          await AppSharedPreferences.removeArLang();
          emit(ChangLanguageState(locale: Locale(AppSharedPreferences.getArLang)));
        }
      }catch(error){
        emit(LanguageErrorState());
      }
    });
  }
}
