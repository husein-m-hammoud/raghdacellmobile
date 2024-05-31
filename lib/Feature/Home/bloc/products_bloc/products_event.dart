part of 'products_bloc.dart';

@immutable
class ProductsEvent {}

class GetSliderImageEvent extends ProductsEvent {}

class GetProductsEvent extends ProductsEvent {
   final String params ;
  GetProductsEvent({this.params = ''});
}

class ProductsSearchEvent extends ProductsEvent{
  final String search;
  ProductsSearchEvent(this.search);
}

class ProductAdditionalServicesIndexSelectedEvent extends ProductsEvent {
  final int index;
  ProductAdditionalServicesIndexSelectedEvent({required this.index});
}

class GetProductsPackagesEvent extends ProductsEvent {
  final int productId;
  GetProductsPackagesEvent({required this.productId});
}

class PlayerNumberEvent extends ProductsEvent {
  final int productPartyApi;
  final int playerNumber;

  PlayerNumberEvent(
      {required this.playerNumber, required this.productPartyApi});
}

class OrderOneEvent extends ProductsEvent {
  final int packageId;
  final String quantity;
  final String playerNumber;
  final String playerName;
  final String emailOrPhoneNumber;
  final String password;
  final String contactNumber;

  OrderOneEvent(
      {required this.packageId,
      required this.emailOrPhoneNumber,
      required this.password,
      required this.contactNumber,
      required this.playerNumber,
      required this.quantity,
      required this.playerName});
}

class OrderThreeEvent extends ProductsEvent {
  final int packageId;
  final String quantity;
  final String playerNumber;
  final String playerName;
  final String emailOrPhoneNumber;
  final String password;
  final String contactNumber;

  OrderThreeEvent(
      {required this.packageId,
      required this.emailOrPhoneNumber,
      required this.password,
      required this.contactNumber,
      required this.playerNumber,
      required this.quantity,
      required this.playerName});
}

class OrderTwoEvent extends ProductsEvent {
  final int productId;
  final String quantity;
  final String playerNumber;
  final String playerName;
  OrderTwoEvent({
    required this.productId,
    required this.playerNumber,
    required this.quantity,
    required this.playerName,
  });
}

class OrderFiveEvent extends ProductsEvent {
  final String productId;
  final String quantity;
  final String walletAddress;

  OrderFiveEvent({
    required this.productId,
    required this.walletAddress,
    required this.quantity,
  });
}

class OrderFourEvent extends ProductsEvent {
  final String productId;
  final String quantity;
  final String serviceType;
  final String link;
  OrderFourEvent({
    required this.productId,
    required this.link,
    required this.serviceType,
    required this.quantity,
  });
}
