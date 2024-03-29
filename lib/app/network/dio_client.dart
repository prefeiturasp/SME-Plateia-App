import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';
import 'package:sme_plateia/core/storages/local_storages.dart';
import 'package:sme_plateia/app/network/dio_interceptors/auth_interceptor.dart';
import 'package:sme_plateia/env.dart';

@module
abstract class DioClient {
  @PostConstruct(preResolve: true)
  Future<Dio> setup(LocalStorage localStorage) async {
    final options = BaseOptions(
      responseType: ResponseType.json,
      baseUrl: Env.URL_API,
    );

    final dio = Dio(options);

    final dioAuth = Dio(dio.options);
    dioAuth.interceptors.add(PrettyDioLogger(
      compact: true,
      error: true,
      request: false,
      responseBody: false,
      responseHeader: false,
      requestBody: false,
      requestHeader: false,
    ));

    dio.interceptors.add(AuthInterceptor(dioAuth));
    dio.interceptors.add(PrettyDioLogger(
      compact: true,
      error: true,
      request: false,
      responseBody: true,
      requestBody: false,
      responseHeader: false,
      requestHeader: false,
    ));

    return dio;
  }
}

extension DioErrorX on DioError {
  bool get isNoConnectionError =>
      type == DioErrorType.unknown && error is SocketException; // import 'dart:io' for SocketException
}

handleNertorkError(DioError e) {
  if (e.isNoConnectionError) {
    throw Failure.serverFailure(message: 'Erro ao se conectar com o servidor');
  }

  if (e.response != null) {
    String message = 'Erro desconhecido';
    switch (e.response!.statusCode) {
      case 401:
      case 403:
      case 500:
        try {
          if ((e.response!.data as Map).containsKey('errors')) {
            message = e.response!.data['errors'][0];
          } else {
            message = e.response!.data['detail'];
          }
        } catch (e) {
          debugPrint(e.toString());
          throw Failure.serverFailure(message: message);
        }

        break;
    }

    throw Failure.serverFailure(message: message);
  } else {
    throw Failure.serverFailure(message: e.error.toString());
  }
}
