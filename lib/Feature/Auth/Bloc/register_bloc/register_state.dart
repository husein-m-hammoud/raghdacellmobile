part of 'register_bloc.dart';

abstract class RegisterStates {}

class AuthState extends RegisterStates {
  bool loadingState;
  // bool successfulState;
  String? message;
  AuthState({
    this.loadingState = false,
    this.message,
    // this.successfulState = false,
  });
}

class CheckBoxState extends RegisterStates {}

class UserNameOrPhoneState extends RegisterStates {}
