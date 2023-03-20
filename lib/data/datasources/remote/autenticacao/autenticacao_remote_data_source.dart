import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:sme_plateia/core/errors/exceptions.dart';
import 'package:sme_plateia/domain/entities/autenticacao/autenticacao.dart';

import 'autenticacao_remote_service.dart';

abstract class IAutenticacaoRemoteDataSource {
  Future<Autenticacao> autenticar({
    required String login,
    required String senha,
  });
}

@Injectable(as: IAutenticacaoRemoteDataSource)
class AutenticacaoRemoteDataSource implements IAutenticacaoRemoteDataSource {
  AutenticacaoRemoteService autenticacaoRemoteService;

  AutenticacaoRemoteDataSource(this.autenticacaoRemoteService);

  @override
  Future<Autenticacao> autenticar({
    required String login,
    required String senha,
  }) async {
    try {
      final response = await autenticacaoRemoteService.autenticar(login: login, senha: senha);

      return response.data;
    } on DioError catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
  }
}
