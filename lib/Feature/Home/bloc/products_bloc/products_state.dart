// ignore_for_file: must_be_immutable

part of 'products_bloc.dart';

@immutable
class HomeState {}

class ProductAdditionalServicesState extends HomeState {}

class SliderImageLoadingState extends HomeState {}

class GetSliderImageState extends HomeState {
  final SliderImageModel sliderImageModel;
  GetSliderImageState({required this.sliderImageModel});
}

class SliderImageErrorState extends HomeState {
  final String message;
  SliderImageErrorState({required this.message});
}

class ProductsLoadingState extends HomeState {}

class GetProductsState extends HomeState {
  final ProductsModel productsModel;
  GetProductsState({required this.productsModel});
}

class ProductsErrorState extends HomeState {
  final String message;
  ProductsErrorState({required this.message});
}

class ProductsPackagesLoadingState extends HomeState {}

class GetProductsPackagesState extends HomeState {
  final ProductsPackagesModel productsPackagesModel;
  GetProductsPackagesState({required this.productsPackagesModel});
}

class ProductsPackagesErrorState extends HomeState {
  final String message;
  ProductsPackagesErrorState({required this.message});
}

class PlayerNumberState extends HomeState {
  final bool isLoading;
  var message;
  String? msg;
  final bool? hasName;
  PlayerNumberState(
      {this.message = "", this.msg = "", this.isLoading = false, this.hasName});
}

class OrderErrorState extends HomeState {
  final String? message;

  OrderErrorState({
    this.message = "",
  });
}

class OrderLoadingState extends HomeState {}

class OrderSuccessfulState extends HomeState {}
