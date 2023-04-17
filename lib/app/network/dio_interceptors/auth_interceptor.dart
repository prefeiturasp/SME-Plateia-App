import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sme_plateia/app/router/app_router.dart';
import 'package:sme_plateia/app/router/app_router.gr.dart';
import 'package:sme_plateia/core/utils/constants.dart';
import 'package:sme_plateia/features/auth/data/datasources/autenticacao_local_datasource.dart';
import 'package:sme_plateia/features/auth/data/models/autenticacao.model.dart';
import 'package:sme_plateia/injector.dart';

enum TokenErrorType { tokenNotFound, refreshTokenHasExpired, failedToRegenerateAccessToken, invalidAccessToken }

enum TokenHeader { none }

class AuthInterceptor extends QueuedInterceptor {
  final _autenticacaoLocalDataSource = sl<IAutenticacaoLocalDataSource>(); // helper class to access your local storage

  AuthInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers["requiresToken"] == false) {
      options.headers.remove("requiresToken");
      return handler.next(options);
    }

    AutenticacaoModel? authData = await _autenticacaoLocalDataSource.getLastToken();

    if (authData == null) {
      await _performLogout();

      final error = DioError(
        requestOptions: options..extra["tokenErrorType"] = TokenErrorType.tokenNotFound,
        type: DioErrorType.unknown,
        message: 'Token nao encontrado',
      );
      return handler.reject(error);
    }

    String accessToken = authData.accessToken;
    String refreshToken = authData.refreshToken;

    final accessTokenHasExpired = Jwt.isExpired(accessToken);
    final refreshTokenHasExpired = Jwt.isExpired(refreshToken);

    var refreshed = true;

    if (refreshTokenHasExpired) {
      _performLogout();

      options.extra["tokenErrorType"] = TokenErrorType.refreshTokenHasExpired;
      final error = DioError(requestOptions: options, type: DioErrorType.unknown);

      return handler.reject(error);
    } else if (accessTokenHasExpired) {
      try {
        var newAccessToken = await _regenerateAccessToken();

        if (newAccessToken != null) {
          accessToken = newAccessToken;
          refreshed = true;
        } else {
          refreshed = false;
        }
      } on DioError catch (e) {
        debugPrint('Erro ao atualizar token: $e');
        refreshed = false;
      }
    }

    if (refreshed) {
      options.headers["Authorization"] = "Bearer $accessToken";
      return handler.next(options);
    } else {
      final error = DioError(
        requestOptions: options..extra["tokenErrorType"] = TokenErrorType.failedToRegenerateAccessToken,
        type: DioErrorType.unknown,
        message: 'Falha ao regenerar o token de acesso',
      );
      return handler.reject(error);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      _performLogout();

      err = DioError(
        type: DioErrorType.unknown,
        requestOptions: err.requestOptions..extra["tokenErrorType"] = TokenErrorType.invalidAccessToken,
        message: 'Token de acesso inválido',
      );
    }

    return handler.next(err);
  }

  Future<void> _performLogout() async {
    await _autenticacaoLocalDataSource.apagarToken();
    await sl<AppRouter>().replaceAll([LoginRoute()]);
  }

  Future<String?> _regenerateAccessToken() async {
    debugPrint('Atualizando AccessToken');

    var dio = Dio();

    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger());
    }

    var authData = await _autenticacaoLocalDataSource.getLastToken();
    final refreshToken = authData!.refreshToken;

    final response = await dio.post(
      "${Endpoint.baseUrl}/autenticacao/token/atualizar/",
      data: {'refresh': refreshToken},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final newAccessToken = response.data["access"];
      await _autenticacaoLocalDataSource.atualizarAccessToken(newAccessToken);

      return newAccessToken;
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      _performLogout();
    }

    return null;
  }
}
