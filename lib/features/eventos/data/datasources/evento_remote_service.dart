import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sme_plateia/features/eventos/data/models/meus_eventos.response.model.dart';

part 'evento_remote_service.g.dart';

@RestApi()
@singleton
abstract class EventoRemoteService {
  @factoryMethod
  factory EventoRemoteService(Dio dio) = _EventoRemoteService;

  @GET('/meus_eventos')
  Future<HttpResponse<MeusEventosResponseModel>> obterEventos({
    @Query('local') String? local,
    @Query('nome') String? nome,
    @Query('page') int? pagina,
    @Query('periodo_inicio') String? periodoInicio,
    @Query('periodo_fim') String? periodoFim,
  });
}
