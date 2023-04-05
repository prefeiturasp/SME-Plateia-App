import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sme_plateia/app/network/dio_client.dart';
import 'package:sme_plateia/features/auth/data/models/autenticacao.model.dart';

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
      throw handleNertorkError(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      final response = await autenticacaoRemoteService.logout();
      return response.data;
    } on DioError catch (e) {
      throw handleNertorkError(e);
    }
  }
}
