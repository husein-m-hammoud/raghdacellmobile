part of 'app_currency_bloc.dart';

@immutable
abstract class AppCurrencyEvent {}

class InitCurrency extends AppCurrencyEvent {}
class LoadingState extends AppCurrencyState{}

class ChangeCurrencyToUSDEvent extends AppCurrencyEvent {}

class ChangeCurrencyToLBPEvent extends AppCurrencyEvent {}
