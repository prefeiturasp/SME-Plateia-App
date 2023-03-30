import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:template/core/domain/failures/failure.codegen.dart';
import 'package:template/features/auth/data/models/autenticacao.model.dart';

import 'autenticacao_remote_service.dart';

abstract class IAutenticacaoRemoteDataSource {
  Future<AutenticacaoModel> autenticar({required String login, required String senha});
  Future<void> logout();
}

@Injectable(as: IAutenticacaoRemoteDataSource)
class AutenticacaoRemoteDataSource implements IAutenticacaoRemoteDataSource {
  AutenticacaoRemoteService autenticacaoRemoteService;

  AutenticacaoRemoteDataSource(this.autenticacaoRemoteService);

  @override
  Future<AutenticacaoModel> autenticar({
    required String login,
    required String senha,
  }) async {
    try {
      final response = await autenticacaoRemoteService.autenticar(rf: login, senha: senha);

      return response.data;
    } on DioError catch (e) {
      debugPrint(e.toString());
      if (e.response!.statusCode == 401) {
        throw Failure.serverFailure(message: e.response!.data['errors'][0]);
      } else {
        throw Failure.serverFailure(message: e.error.toString());
      }
    }
  }

  @override
  Future<void> logout() async {
    try {
      final response = await autenticacaoRemoteService.logout();
      return response.data;
    } on DioError catch (e) {
      debugPrint(e.toString());
      if (e.response!.statusCode == 401) {
        throw Failure.serverFailure(message: e.response!.data['errors'][0]);
      } else {
        throw Failure.serverFailure(message: e.error.toString());
      }
    }
  }
}
