import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sme_plateia/data/dtos/autenticacao/autenticacao_dto.dart';

part 'autenticacao_remote_service.g.dart';

@RestApi(baseUrl: "/v1/login")
@singleton
abstract class AutenticacaoRemoteService {
  @factoryMethod
  factory AutenticacaoRemoteService(Dio dio) = _AutenticacaoRemoteService;

  @POST('/')
  Future<HttpResponse<AutenticacaoDto>> autenticar({
    required String login,
    required String senha,
  });
}
