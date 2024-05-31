// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

// class LogInEvent extends RegisterEvent {
//   final String userName;
//   final String password;
//   final String phone;
//   LogInEvent({
//     this.userName = "",
//     this.phone = "",
//     required this.password,
//   });
// }

class ToggleCheckBox extends RegisterEvent {
  final bool value;
  ToggleCheckBox({
    required this.value,
  });
}

class UserNameOrPhoneNumber extends RegisterEvent {
  final bool isUserName;
  UserNameOrPhoneNumber({required this.isUserName});
}

class CheckVerificationCodeAndSignUpEvent extends RegisterEvent {
  final String email;
  final String username;
  final String phone;
  final String password;
  final String verificationCode;
  CheckVerificationCodeAndSignUpEvent(
      {required this.email,
      required this.password,
      required this.phone,
      required this.username,
      this.verificationCode = ""});
}

class CheckEmailSendVerificationCodeEvent extends RegisterEvent {
  final String email;
  CheckEmailSendVerificationCodeEvent({required this.email});
}

class CheckVerifiCodeAndEmailForForgetPasswordEvent extends RegisterEvent {
  final String email;
  final String verifiCode;
  CheckVerifiCodeAndEmailForForgetPasswordEvent(
      {required this.email, this.verifiCode = ""});
}

class CheckVerifiCodeAndLoginEvent extends RegisterEvent {
  final String verificationCode;
  final String phone;
  final String userName;
  final String password;

  CheckVerifiCodeAndLoginEvent(
      {this.userName = "",
      this.verificationCode = "",
      this.phone = "",
      required this.password});
}

class ResetPasswordEvent extends RegisterEvent {
  final String email;
  final String password;
  final String confirmPassword;
  final String verificode;
  ResetPasswordEvent(
      {required this.confirmPassword,
      required this.password,
      required this.email,
      required this.verificode});
}
