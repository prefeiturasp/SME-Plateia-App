import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';
import 'package:sme_plateia/core/storages/local_storages.dart';
import 'package:sme_plateia/core/utils/constants.dart';
import 'package:sme_plateia/app/network/dio_interceptors/auth_interceptor.dart';

import 'dio_interceptors/auth_interceptor.dart';

@module
abstract class DioClient {
  @PostConstruct(preResolve: true)
  Future<Dio> setup(LocalStorage localStorage) async {
    final options = BaseOptions(
      responseType: ResponseType.json,
      baseUrl: Endpoint.baseUrl,
    );

    final dio = Dio(options);

    dio.interceptors.add(AuthInterceptor());
    dio.interceptors.add(PrettyDioLogger(compact: true));

    return dio;
  }
}

extension DioErrorX on DioError {
  bool get isNoConnectionError =>
      type == DioErrorType.unknown &&
      error is SocketException; // import 'dart:io' for SocketException
}

handleNertorkError(DioError e) {
  if (e.isNoConnectionError) {
    throw Failure.serverFailure(message: 'Erro ao se conectar com o servidor');
  }

  if (e.response != null) {
    String message = 'Erro desconhecido';
    switch (e.response!.statusCode) {
      case 401:
        if ((e.response!.data as Map).containsKey('errors')) {
          message = e.response!.data['errors'][0];
        } else {
          message = e.response!.data['detail'];
        }
        break;
    }

    throw Failure.serverFailure(message: message);
  } else {
    throw Failure.serverFailure(message: e.error.toString());
  }
}
