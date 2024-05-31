part of 'wallet_datails_bloc.dart';

@immutable
class WalletDetailsEvent {}

class GetAndFilterWalletDetailsEvent extends WalletDetailsEvent {
  final String? endDate;
  final String? startDate;
  final String? status;
  GetAndFilterWalletDetailsEvent(
      {this.endDate, this.startDate = "2002-01-01", this.status = ""});
}
