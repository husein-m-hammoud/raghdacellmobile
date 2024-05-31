// ignore_for_file: prefer_if_null_operators

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:raghadcell/Apis/ExceptionsHandle.dart';
import 'package:raghadcell/Apis/Network.dart';
import 'package:raghadcell/Apis/Urls.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/models/orders_model.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersInitialstate()) {
    on<OrdersEvent>((event, emit) async {
      if (event is GetAndFilterOrdersEvent) {
        emit(OrdersLoadingState());
        DateTime now = DateTime.now();
        String date = now.toString().substring(0, 10);
        String hours = now.toString().substring(11, 19);
        // String hours = "00:00:00";
        print(
            " ======================================$hours =========== $now ================= $date");

        try {
          final response = await Network.getData(
              url:
                  // "${Urls.orders}?end_date=${event.endDate == null ? date : event.endDate}%2000:00:00&start_date=${event.startDate}%2000:00:00&status=${event.status}&local=${AppSharedPreferences.getArLang}");
                  "${Urls.orders}?end_date=${event.endDate == null ? "" : "${event.endDate} $hours"}&start_date=${event.startDate} $hours&status=${event.status}&local=${AppSharedPreferences.getArLang}");
          OrdersViewModel ordersViewModel =
              OrdersViewModel.fromJson(response.data);

          emit(GetOrdersState(ordersModerl: ordersViewModel));
        } catch (error) {
          if (error is DioException) {
            emit(OrdersErrorState(message: exceptionsHandle(error: error)));
          } else {
            emit(OrdersErrorState(message: error.toString()));
          }
        }
      }

      //?
    });
  }
}
