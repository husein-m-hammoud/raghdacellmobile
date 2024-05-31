part of 'orders_bloc.dart';

@immutable
class OrdersState {}

class OrdersInitialstate extends OrdersState {}

class OrdersLoadingState extends OrdersState {}

class GetOrdersState extends OrdersState {
  final OrdersViewModel ordersModerl;
  GetOrdersState({required this.ordersModerl});
}

class OrdersErrorState extends OrdersState {
  final String message;
  OrdersErrorState({this.message = ""});
}
