import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sme_plateia/app/network/dio_client.dart';
import 'package:sme_plateia/features/eventos/data/models/evento_resumo.model.dart';

import 'evento_remote_service.dart';

abstract class IEventoRemoteDataSource {
  Future<List<EventoResumoModel>> obterEventos({
    String? nome,
    int? ativos,
    String? local,
    int? pagina,
  });
}

@Injectable(as: IEventoRemoteDataSource)
class EventoRemoteDataSource implements IEventoRemoteDataSource {
  final EventoRemoteService eventoRemoteService;

  EventoRemoteDataSource(this.eventoRemoteService);

  @override
  Future<List<EventoResumoModel>> obterEventos({
    String? nome,
    int? ativos,
    String? local,
    int? pagina,
  }) async {
    try {
      final response = await eventoRemoteService.obterEventos(nome: nome, local: local, pagina: pagina, ativos: ativos);

      return response.data.resultados;
    } on DioError catch (e) {
      throw handleNertorkError(e);
    }
  }
}
