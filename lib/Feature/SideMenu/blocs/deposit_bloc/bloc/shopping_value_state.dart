part of 'shopping_value_bloc.dart';

@immutable
class ShoppingValueState {}

class ShoppingValueInitial extends ShoppingValueState {}

class ShoppingValueCheckState extends ShoppingValueState {
  final bool isLoading;
  final String message;
  ShoppingValueCheckState({this.isLoading = false, this.message = ""});
}
