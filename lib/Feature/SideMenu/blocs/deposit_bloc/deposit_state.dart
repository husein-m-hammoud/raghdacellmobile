part of 'deposit_bloc.dart';

@immutable
abstract class DepositState {}

class GetDepositInformationInitialState extends DepositState {}

class GetDepositInformationErrorState extends DepositState {
  final String? message;
  GetDepositInformationErrorState({this.message});
}

class GetDepositInformationLoadingAndErrorState extends DepositState {
  final bool isLoading;
  final String? message;

  GetDepositInformationLoadingAndErrorState(
      {this.isLoading = false, this.message});
}

class GetDepositInformationState extends DepositState {
  final DepositInformationModel depositInformationModel;
  GetDepositInformationState({required this.depositInformationModel});
}
