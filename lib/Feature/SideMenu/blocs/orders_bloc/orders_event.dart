part of 'orders_bloc.dart';

@immutable
abstract class OrdersEvent {}

class GetAndFilterOrdersEvent extends OrdersEvent {
  final String? endDate;
  final String? startDate;
  final String? status;
  GetAndFilterOrdersEvent(
      {this.endDate, this.startDate = "2000-01-01", this.status = ""});
}
