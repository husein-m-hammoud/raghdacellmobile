part of 'app_currency_bloc.dart';

@immutable
class AppCurrencyState {}
class CurrencyInitialState extends AppCurrencyState{}
class AppCurrencyErrorState extends AppCurrencyState {
  final String message;
  AppCurrencyErrorState({required this.message});
}

class ChangeCurrency extends AppCurrencyState {
  final String currency;
  final String? message;

  ChangeCurrency({required this.currency, this.message});
}
