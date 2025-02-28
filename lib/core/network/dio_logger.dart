import 'dart:developer';

import 'package:dio/dio.dart';

import '/core/network/api_constance.dart';

class DioLogger {
  Dio getDio() {
    Dio dio = Dio();

    dio.options.baseUrl = ApiConstance.baseUrl;

    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ApiConstance.token}',
    };

    dio.interceptors.add(
      LogInterceptor(
        requestHeader: true,
        requestBody: true,
        // responseBody: true,
        request: true,
        error: true,
        responseHeader: true,
        logPrint: (object) {
          log(object.toString(), name: 'Dio Log');
        },
      ),
    );
    return dio;
  }
}
