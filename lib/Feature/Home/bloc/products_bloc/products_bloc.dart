// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:raghadcell/Apis/ExceptionsHandle.dart';
import 'package:raghadcell/Apis/Network.dart';
import 'package:raghadcell/Apis/Urls.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Feature/Home/models/products_model.dart';
import 'package:raghadcell/Feature/Home/models/products_packages_model.dart';
import 'package:raghadcell/Feature/Home/models/slider_image_model.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, HomeState> {
  int page = 1;
  ProductsModel? productsModel;
  bool? hasName;
  RefreshController refreshController = RefreshController();
  int? productAdditionalServicesIndexSelected = 0;
  ProductsBloc() : super(ProductsLoadingState()) {

    on<GetSliderImageEvent>((event, emit) async {
      emit(SliderImageLoadingState());
      try {
        final response = await Network.getData(url: Urls.sliderImages);
        SliderImageModel sliderImageModel =
            SliderImageModel.fromJson(response.data);

        emit(GetSliderImageState(sliderImageModel: sliderImageModel));
      } catch (error) {

        if (error is DioException) {
          emit(SliderImageErrorState(message: exceptionsHandle(error: error)));
        } else {
          emit(SliderImageErrorState(message: error.toString()));
        }
      }
    });

    on<PlayerNumberEvent>((event, emit) async {
      emit(PlayerNumberState(isLoading: true));
      try {
        await Network.postData(
            url: "${Urls.baseUrl}/th-p-apis/${event.productPartyApi}",
            data: {"number": event.playerNumber}).then((response) {
          // print(response.data['data']['msg']);
          hasName = response.data['error'] == null;
          emit(PlayerNumberState(
              message: response.data['error'] == null
                  ? response.data['data']['username']
                  : response.data['msg']));
        });

        emit(PlayerNumberState(isLoading: false));
      } catch (error) {
        if (error is DioException) {
          emit(PlayerNumberState(message: exceptionsHandle(error: error)));
        } else {
          emit(PlayerNumberState(message: error.toString()));
        }
      }
    });

    on<OrderOneEvent>((event, emit) async {
      emit(OrderLoadingState());
      try {
        int.parse(event.quantity);
        await Network.postData(url: Urls.orders, data: {
          if (event.playerNumber != "") "player_number": event.playerNumber,
          //
          "quantity": event.quantity,
          "package_id": event.packageId,
          //
          if (event.password != "") "password": event.password,
          if (event.contactNumber != "") "contact_number": event.contactNumber,
          if (event.emailOrPhoneNumber != "")
            "email_or_phone_number": event.emailOrPhoneNumber,
          if (event.playerName != "") "player_name": event.playerName
        });

        emit(OrderSuccessfulState());
      } on FormatException {
        emit(OrderErrorState(message: "Please Enter the correct number"));
      } catch (error) {
        if (error is DioException) {
          emit(OrderErrorState(message: exceptionsHandle(error: error)));
        } else {
          emit(OrderErrorState(message: error.toString()));
        }
      }
    });
    on<OrderTwoEvent>((event, emit) async {
      emit(OrderLoadingState());
      try {
        int.parse(event.quantity);
        await Network.postData(
          url: Urls.orders,
          data: {
            if (event.playerNumber != "") "player_number": event.playerNumber,
            if (event.playerName != "") "player_name": event.playerName,
            "quantity": event.quantity,
            "product_id": event.productId,
          },
        );

        emit(OrderSuccessfulState());
      } on FormatException {
        emit(OrderErrorState(message: "Please Enter the correct number"));
      } catch (error) {
        if (error is DioException) {
          emit(OrderErrorState(message: exceptionsHandle(error: error)));
        } else {
          emit(OrderErrorState(message: error.toString()));
        }
      }
    });
    on<OrderFiveEvent>((event, emit) async {
      emit(OrderLoadingState());
      try {
        int.parse(event.quantity);
        await Network.postData(
          url: Urls.orders,
          data: {
            "wallet_address": event.walletAddress,
            "quantity": event.quantity,
            "product_id": event.productId,
          },
        );

        emit(OrderSuccessfulState());
      } on FormatException {
        emit(OrderErrorState(message: "Please Enter the correct number"));
      } catch (error) {
        if (error is DioException) {
          emit(OrderErrorState(message: exceptionsHandle(error: error)));
        } else {
          emit(OrderErrorState(message: error.toString()));
        }
      }
    });
    on<OrderFourEvent>((event, emit) async {
      emit(OrderLoadingState());
      try {
        int.parse(event.quantity);
        await Network.postData(
          url: Urls.orders,
          data: {
            "service_type": event.serviceType,
            "quantity": event.quantity,
            "product_id": event.productId,
            "social_link": event.link
          },
        );

        emit(OrderSuccessfulState());
      } on FormatException {
        emit(OrderErrorState(message: "Please Enter the correct number"));
      } catch (error) {
        if (error is DioException) {
          emit(OrderErrorState(message: exceptionsHandle(error: error)));
        } else {
          emit(OrderErrorState(message: error.toString()));
        }
      }
    });
    on<GetProductsPackagesEvent>((event, emit) async {
      emit(ProductsPackagesLoadingState());
      try {
        final response = await Network.getData(
            url:
                "${Urls.baseUrl}/products/${event.productId}/packages?local=${AppSharedPreferences.getArLang}");
        ProductsPackagesModel productsPackagesModel =
            ProductsPackagesModel.fromJson(response.data);

        emit(GetProductsPackagesState(
            productsPackagesModel: productsPackagesModel));
      } catch (error) {
        if (error is DioException) {
          emit(ProductsPackagesErrorState(
              message: exceptionsHandle(error: error)));
        } else {
          emit(ProductsPackagesErrorState(message: error.toString()));
        }
      }
    });

    //
    on<GetProductsEvent>((event, emit) async {
      if (page == 1) {
        emit(ProductsLoadingState());
      }
      try {
        final response = await Network.getData(
            url:
                "${Urls.baseUrl}/products?paginate=1&page=$page&local=${AppSharedPreferences.getArLang}${event.params}");

        ProductsModel result = ProductsModel.fromJson(response.data);
        if (result.data!.products!.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        if (page == 1) {
          productsModel = result;
        } else {
          productsModel!.data!.products!.addAll(result.data!.products!);
        }
        emit(GetProductsState(productsModel: productsModel!));
        page++;
      } catch (error) {
          print("error is $error");
        if (page == 1) {
          if (error is DioException) {
            emit(ProductsErrorState(message: exceptionsHandle(error: error)));
          } else {
            ProductsErrorState(message: error.toString());
          }
        }else{
          refreshController.loadFailed();
        }
      }
    });
    //
    on<ProductAdditionalServicesIndexSelectedEvent>((event, emit) {
      productAdditionalServicesIndexSelected = event.index;

      emit(ProductAdditionalServicesState());
    });
    on<OrderThreeEvent>((event, emit) async {
      emit(OrderLoadingState());
      try {
        int.parse(event.quantity);
        await Network.postData(url: Urls.orders, data: {
          if (event.playerNumber != "") "player_number": event.playerNumber,
          //
          "quantity": event.quantity,
          "package_id": event.packageId,
          //
          if (event.password != "") "password": event.password,
          if (event.contactNumber != "") "contact_number": event.contactNumber,
          if (event.emailOrPhoneNumber != "")
            "email_or_phone_number": event.emailOrPhoneNumber,
          if (event.playerName != "") "player_name": event.playerName
        });

        emit(OrderSuccessfulState());
      } on FormatException {
        emit(OrderErrorState(message: "Please Enter the correct number"));
      } catch (error) {
        if (error is DioException) {
          emit(OrderErrorState(message: exceptionsHandle(error: error)));
        } else {
          emit(OrderErrorState(message: error.toString()));
        }
      }
    });


    on<ProductsSearchEvent>((event, emit) async {
      emit(ProductsLoadingState());
      try {
        final response = await Network.getData(
            url:
            "${Urls.baseUrl}/products?search=${event.search}&paginate=1&local=${AppSharedPreferences.getArLang}");

        productsModel = ProductsModel.fromJson(response.data);
        emit(GetProductsState(productsModel: productsModel!));
      } catch (error) {
        if (error is DioException) {
          emit(ProductsErrorState(
              message: exceptionsHandle(error: error)));
        } else {
          ProductsErrorState(message: error.toString());
        }
      }
    });

  }
  void checkPlayerNumber(){

  }

}
