import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:raghadcell/Apis/ExceptionsHandle.dart';
import 'package:raghadcell/Apis/Network.dart';
import 'package:raghadcell/Apis/Urls.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';

part 'app_currency_event.dart';
part 'app_currency_state.dart';

class AppCurrencyBloc extends Bloc<AppCurrencyEvent, AppCurrencyState> {
  AppCurrencyBloc()
      : super(CurrencyInitialState()) {
    on<AppCurrencyEvent>((event, emit) async {
      // if (event is InitCurrency) {
      //   emit(ChangeCurrency(currency: AppSharedPreferences.getCurrency));
      // }
    });
    on<ChangeCurrencyToUSDEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final response = await Network.postData(
            url: Urls.changeCurrency, data: {"currency": "USD"});
        if (response.statusCode == 200 || response.statusCode == 201) {
          await AppSharedPreferences.saveCurrency("USD");
          await Future.delayed(const Duration(seconds: 1)).then((value) {
            emit(ChangeCurrency(
                currency: AppSharedPreferences.getCurrency,
                message: response.data['data']));
          });
        }
      } catch (error) {
        if (error is DioException) {
          emit(AppCurrencyErrorState(message: exceptionsHandle(error: error)));
        } else {
          emit(AppCurrencyErrorState(message: error.toString()));
        }
      }
    });
    on<ChangeCurrencyToLBPEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final response = await Network.postData(
            url: Urls.changeCurrency, data: {"currency": "LBP"});
        if (response.statusCode == 200 || response.statusCode == 201) {
          await AppSharedPreferences.saveCurrency("LBP");
          await Future.delayed(const Duration(seconds: 1)).then((value) {
            emit(ChangeCurrency(
                currency: AppSharedPreferences.getCurrency,
                message: response.data['data']));
          });
        }
      } catch (error) {
        if (error is DioException) {
          emit(AppCurrencyErrorState(message: exceptionsHandle(error: error)));
        } else {
          emit(AppCurrencyErrorState(message: error.toString()));
        }
      }
    });
  }
}
