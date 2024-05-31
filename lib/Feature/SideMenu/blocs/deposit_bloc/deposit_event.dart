part of 'deposit_bloc.dart';

@immutable
abstract class DepositEvent {}

class GetDepositInformationEvent extends DepositEvent {}

class UDSTAndWishMonyChargingWalletEvent extends DepositEvent {
  final String value;
  final String type;
  final String image;
  UDSTAndWishMonyChargingWalletEvent(
      {required this.image, required this.type, required this.value});
}

class PromoCodeChargingWalletEvent extends DepositEvent {
  final String value;

  PromoCodeChargingWalletEvent({required this.value});
}
