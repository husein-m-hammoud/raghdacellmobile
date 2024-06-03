// ignore_for_file: file_names

import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';

class Urls {
  // static String baseUrl = "https://backend.raghdacell.com/api";
  // static String storage = 'https://backend.raghdacell.com/storage/';
   static String baseUrl = "https://dev-backend.raghdacell.com/api";
  static String storage = 'https://dev-backend.raghdacell.com/storage/';
  static String loginCheck =
      '$baseUrl/login?check=1&local=${AppSharedPreferences.getArLang}';
  static String signUpCheck =
      '$baseUrl/signup?validate=1&local=${AppSharedPreferences.getArLang}';
  static String signUpVerification =
      '$baseUrl/signup?auth=1&local=${AppSharedPreferences.getArLang}';
  static String loginVerification =
      '$baseUrl/login?auth=1&local=${AppSharedPreferences.getArLang}';
  static String forgetCheckEmail =
      '$baseUrl/send/verification-code?local=${AppSharedPreferences.getArLang}';
  static String reserPassword =
      '$baseUrl/reset-password?local=${AppSharedPreferences.getArLang}';
  static String forgetVerificationEmail =
      '$baseUrl/check/verification-code?local=${AppSharedPreferences.getArLang}';
  static String profile =
      '$baseUrl/profile?local=${AppSharedPreferences.getArLang}';
  static String sliderImages = '$baseUrl/slider/images';
  static String getContactUsInfoText =
      '$baseUrl/contact-us/info?local=${AppSharedPreferences.getArLang}';
  static String sendMessagesContactUs =
      '$baseUrl/messages?local=${AppSharedPreferences.getArLang}';
  static String aboutUs =
      '$baseUrl/about-us/info?local=${AppSharedPreferences.getArLang}';
  static String allProducts =
      '$baseUrl/products?local=${AppSharedPreferences.getArLang}';
  static String orders =
      '$baseUrl/orders?local=${AppSharedPreferences.getArLang}';
      static String orderSix =
      '$baseUrl/automated/get/packages?local=${AppSharedPreferences.getArLang}';
  static String wallet = '$baseUrl/payment-logs';
  static String depositInformation =
      '$baseUrl/payments/info?local=${AppSharedPreferences.getArLang}';
  static String changeCurrency =
      '$baseUrl/change-currency?local=${AppSharedPreferences.getArLang}';
}
