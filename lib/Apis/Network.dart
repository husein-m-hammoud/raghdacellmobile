// ignore_for_file: file_names, deprecated_member_use

import 'dart:io';

import 'package:dio/io.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';

class Network {
  static late Dio dio;
  HttpClient? httpClient;
  static init() {
    dio = Dio(BaseOptions(
      headers: {
        // 'Authorization': "Bearer ${AppSharedPreferences.getToken}",
        'Content-Type': 'application/json',
        "Accept": 'application/json',
        "Accept-Charset": "application/json"
      },
      connectTimeout: const Duration(seconds: 20),
      // receiveTimeout: const Duration(seconds: 30)
    ));

    dio.interceptors.add(PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        request: true,
        compact: true,
        maxWidth: 1000));

    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      return client;
    };
  }

  static Future<Response> getData({
    required String url,
  }) async {
    dio.options.headers = {
      'Authorization': "Bearer ${AppSharedPreferences.getToken}",
      'Content-Type': 'application/json',
      "Accept": 'application/json',
      "Accept-Charset": "application/json"
    };
    final response = await dio.get(
      url,
    );
    return response;
  }

  static Future<Response> postData({
    required String url,
    var data,
  }) async {
    dio.options.headers = {
      'Authorization': "Bearer ${AppSharedPreferences.getToken}",
      'Content-Type': 'application/json',
      "Accept": 'application/json',
      "Accept-Charset": "application/json"
    };
    return await dio.post(
      url,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    dio.options.headers = {
      'Authorization': "Bearer ${AppSharedPreferences.getToken}",
      'Content-Type': 'application/json',
      "Accept": 'application/json',
      "Accept-Charset": "application/json"
    };
    return await dio.put(url, data: data);
  }

  static Future<Response> patchData({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    dio.options.headers = {
      'Authorization': "Bearer ${AppSharedPreferences.getToken}",
      'Content-Type': 'application/json',
      "Accept": 'application/json',
      "Accept-Charset": "application/json"
    };
    return await dio.patch(url, data: data);
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    return await dio.delete(url, data: data);
  }
}
