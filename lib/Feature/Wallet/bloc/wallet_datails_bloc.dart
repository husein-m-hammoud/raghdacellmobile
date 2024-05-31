// ignore_for_file: prefer_if_null_operators

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:raghadcell/Apis/ExceptionsHandle.dart';
import 'package:raghadcell/Apis/Network.dart';
import 'package:raghadcell/Apis/Urls.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Feature/Wallet/Presentation/model/view_wallet_model.dart';

part 'wallet_datails_event.dart';
part 'wallet_datails_state.dart';

class WalletDetailsBloc extends Bloc<WalletDetailsEvent, WalletDetailsState> {
  WalletDetailsBloc() : super(WalletDetailsInitState()) {
    on<WalletDetailsEvent>((event, emit) async {
      if (event is GetAndFilterWalletDetailsEvent) {
        emit(WalletDetailsLoadingState());
        DateTime now = DateTime.now();
        String date = now.toString().substring(0, 10);
        String hours = now.toString().substring(11, 19);
        // String hours = "00:00:00";
        print(
            " ======================================$hours =========== $now ================= $date");

        try {
          final response = await Network.getData(
              url:
                  "${Urls.wallet}?local=${AppSharedPreferences.getArLang}&end_date=${event.endDate == null ? "" : "${event.endDate} $hours"}&start_date=${event.startDate} $hours&status=${event.status}");
          ViewWalletModel viewWalletModel =
              ViewWalletModel.fromJson(response.data);

          emit(GetWalletDetailsState(viewWalletModel: viewWalletModel));
        } catch (error) {
          if (error is DioException) {
            emit(WalletDetailsErrorState(
                message: exceptionsHandle(error: error)));
          } else {
            emit(WalletDetailsErrorState(message: error.toString()));
          }
        }
      }
    });
  }
}
