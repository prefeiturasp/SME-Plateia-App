import 'package:dio/dio.dart' hide Headers;
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sme_plateia/features/eventos/data/models/evento_detalhes.model.dart';

part 'evento_detalhes_remote_service.g.dart';

@RestApi()
@LazySingleton()
abstract class EventoDetalhesRemoteService {
  @factoryMethod
  factory EventoDetalhesRemoteService(Dio dio) = _EventoDetalhesRemoteService;

  @GET('/meus_eventos/{id}/')
  Future<HttpResponse<EventoDetalhesModel>> obterDetalhesEvento({
    @Path('id') required int idEvento,
  });
}
