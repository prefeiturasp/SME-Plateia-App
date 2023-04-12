import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sme_plateia/features/eventos/data/model/meus_eventos.response.model.dart';

part 'evento_remote_service.g.dart';

@RestApi()
@singleton
abstract class EventoRemoteService {
  @factoryMethod
  factory EventoRemoteService(Dio dio) = _EventoRemoteService;

  @GET('/meus_eventos')
  Future<HttpResponse<MeusEventosResponseModel>> obterEventos({
    @Field('local') String? local,
    @Field('nome') String? nome,
    @Field('page') int? pagina,
    @Field('periodo_inicio') String? periodoInicio,
    @Field('periodo_fim') String? periodoFim,
  });
}
