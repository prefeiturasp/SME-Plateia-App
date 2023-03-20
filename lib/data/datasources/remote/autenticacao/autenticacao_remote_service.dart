import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sme_plateia/domain/entities/autenticacao/autenticacao.dart';

part 'autenticacao_remote_service.g.dart';

@RestApi(baseUrl: "/v1/login")
@singleton
abstract class AutenticacaoRemoteService {
  @factoryMethod
  factory AutenticacaoRemoteService(Dio dio, {String baseUrl}) = _AutenticacaoRemoteService;

  @POST('/')
  Future<HttpResponse<Autenticacao>> autenticar({
    required String login,
    required String senha,
  });
}
