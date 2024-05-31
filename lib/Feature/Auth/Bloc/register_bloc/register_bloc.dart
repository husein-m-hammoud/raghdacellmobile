import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:raghadcell/Apis/ExceptionsHandle.dart';
import 'package:raghadcell/Apis/Network.dart';
import 'package:raghadcell/Apis/Urls.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterStates> {
  bool checkBoxValue = false;
  bool isUserName = false;
  RegisterBloc() : super(AuthState()) {
    on<CheckVerifiCodeAndLoginEvent>(
      (event, emit) async {
        emit(AuthState(loadingState: true));
        String? fcmToken = await FirebaseMessaging.instance.getToken();

        try {

          final response = await Network.postData(
              url: event.verificationCode == ""
                  ? Urls.loginCheck
                  : Urls.loginVerification,
              data: {
                if (event.phone != "") "phone_number": event.phone,
                if (event.userName != "") "username": event.userName,
                "password": event.password,
                if (event.verificationCode != "")
                  "verification_code": event.verificationCode,
                "fcm_token": fcmToken
              });
          if (event.verificationCode != "") {
            AppSharedPreferences.saveToken(response.data['data']['token']);
            AppSharedPreferences.saveCurrency(
                response.data['data']['user']['currency']);

            AppSharedPreferences.preferences
                .setString("password", event.password);
          }
          emit(AuthState(loadingState: false));
        } catch (error) {
          if (error is DioException) {
            emit(AuthState(message: exceptionsHandle(error: error)));
          } else {
            emit(AuthState(message: error.toString()));
          }
        }
      },
    );

    on<ToggleCheckBox>((event, emit) async {
      checkBoxValue = event.value;
      emit(CheckBoxState());
    });
    on<UserNameOrPhoneNumber>((event, emit) {
      isUserName = event.isUserName;
      emit(UserNameOrPhoneState());
    });

    on<CheckVerificationCodeAndSignUpEvent>(
      (event, emit) async {
        emit(AuthState(loadingState: true));
        String? fcmToken = await FirebaseMessaging.instance.getToken();
        try {
          final response = await Network.postData(
              url: event.verificationCode == ""
                  ? Urls.signUpCheck
                  : Urls.signUpVerification,
              data: {
                "username": event.username,
                "password": event.password,
                "email": event.email,
                "phone_number": event.phone,
                if (event.verificationCode != "")
                  "verification_code": event.verificationCode,
                "fcm_token": fcmToken
              });
          if (event.verificationCode != "") {
            AppSharedPreferences.saveToken(response.data['data']['token']);
            AppSharedPreferences.saveCurrency(
                response.data['data']['user']['currency']??"USD");

            AppSharedPreferences.preferences
                .setString("password", event.password);
          }
          emit(AuthState(loadingState: false));

        } catch (error) {
          if (error is DioException) {
            emit(AuthState(message: exceptionsHandle(error: error)));
          } else {
            emit(AuthState(message: error.toString()));
          }
        }
      },
    );

    on<CheckVerifiCodeAndEmailForForgetPasswordEvent>(
      (event, emit) async {
        emit(AuthState(loadingState: true));
        try {
          await Network.postData(
              url: event.verifiCode == ""
                  ? Urls.forgetCheckEmail
                  : Urls.forgetVerificationEmail,
              data: {
                "email": event.email,
                if (event.verifiCode != "")
                  "verification_code": event.verifiCode
              }).then((value) {});
          emit(AuthState(loadingState: false));
        } catch (error) {
          if (error is DioException) {
            emit(AuthState(message: exceptionsHandle(error: error)));
          } else {
            emit(AuthState(message: error.toString()));
          }
        }
      },
    );
    on<ResetPasswordEvent>(
      (event, emit) async {
        emit(AuthState(loadingState: true));
        try {
          await Network.postData(url: Urls.reserPassword, data: {
            "email": event.email,
            "password": event.password,
            "password_confirmation": event.confirmPassword,
            "verification_code": event.verificode
          }).then((value) {});
          emit(AuthState(loadingState: false));
        } catch (error) {
          if (error is DioException) {
            emit(AuthState(message: exceptionsHandle(error: error)));
          } else {
            emit(AuthState(message: error.toString()));
          }
        }
      },
    );
  }
}
//sign in - verification - goto page
//signup - verification - sign in gotopage
//forget - emailcheck - verification - resetpassword - sign in
