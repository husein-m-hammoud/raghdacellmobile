// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:raghadcell/App/app.dart';
import 'package:raghadcell/App/app_localizations.dart';

String exceptionsHandle({required DioException error}) {
  String? message;
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      message = 'Server not reachable'.tr(navigatorKey.currentContext!);
      break;

    case DioExceptionType.sendTimeout:
      message = 'Send Time out'.tr(navigatorKey.currentContext!);
      break;
    case DioExceptionType.receiveTimeout:
      message = 'Server not reachable'.tr(navigatorKey.currentContext!);
      break;
    case DioExceptionType.badResponse:
      message = error.response!.data['message'];
      break;
    case DioExceptionType.cancel:
      message = 'Request is cancelled'.tr(navigatorKey.currentContext!);
      break;
    case DioExceptionType.unknown:
      error.message!.contains('SocketException')
          ? message =
              'check your internet connection'.tr(navigatorKey.currentContext!)
          : message = error.message!;
      break;
    case DioExceptionType.badCertificate:
      message = 'Bad Certificate'.tr(navigatorKey.currentContext!);

      break;
    case DioExceptionType.connectionError:
      message = 'Connection Error'.tr(navigatorKey.currentContext!);
      break;
  }
  return message!;
}
