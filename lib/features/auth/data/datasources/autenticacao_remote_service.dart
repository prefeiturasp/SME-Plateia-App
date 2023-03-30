import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:template/features/auth/data/models/autenticacao.model.dart';

part 'autenticacao_remote_service.g.dart';

@RestApi()
@singleton
abstract class AutenticacaoRemoteService {
  @factoryMethod
  factory AutenticacaoRemoteService(Dio dio) = _AutenticacaoRemoteService;

  @POST('/autenticacao/entrar')
  Future<HttpResponse<AutenticacaoModel>> autenticar({
    @Field('rf') required String rf,
    @Field('password') required String senha,
  });

  @POST('/autenticacao/sair')
  Future<HttpResponse<void>> logout();

  @POST('/autenticacao/token/atualizar')
  Future<HttpResponse<AutenticacaoModel>> refreshToken({
    @Field('refresh') required String token,
  });
}
