import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:raghadcell/Apis/ExceptionsHandle.dart';
import 'package:raghadcell/Apis/Network.dart';
import 'package:raghadcell/Apis/Urls.dart';

part 'shopping_value_event.dart';
part 'shopping_value_state.dart';

class ShoppingValueBloc extends Bloc<ShoppingValueEvent, ShoppingValueState> {
  ShoppingValueBloc() : super(ShoppingValueCheckState()) {
    on<ShoppingValueEvent>((event, emit) async {
      emit(ShoppingValueCheckState(isLoading: true));
      try {
        await Network.postData(
          url: "${Urls.baseUrl}/promo-codes/check?code=${event.code}",
          // data: {"code": event.code}
        );
        emit(ShoppingValueCheckState(isLoading: false));
      } catch (error) {
        if (error is DioException) {
          emit(
              ShoppingValueCheckState(message: exceptionsHandle(error: error)));
        } else {
          emit(ShoppingValueCheckState(message: error.toString()));
        }
      }
    });
  }
}
