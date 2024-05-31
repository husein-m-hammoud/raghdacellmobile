part of 'wallet_datails_bloc.dart';

@immutable
abstract class WalletDetailsState {}

class WalletDetailsInitState extends WalletDetailsState {}

class WalletDetailsLoadingState extends WalletDetailsState {}

class GetWalletDetailsState extends WalletDetailsState {
  final ViewWalletModel viewWalletModel;
  GetWalletDetailsState({required this.viewWalletModel});
}

class WalletDetailsErrorState extends WalletDetailsState {
  final String message;
  WalletDetailsErrorState({required this.message});
}
