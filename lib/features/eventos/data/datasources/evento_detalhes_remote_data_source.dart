import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sme_plateia/app/network/dio_client.dart';
import 'package:sme_plateia/features/eventos/data/datasources/evento_detalhes_remote_service.dart';
import 'package:sme_plateia/features/eventos/data/models/evento_detalhes.model.dart';

abstract class IEventoDetalhesRemoteDataSource {
  Future<EventoDetalhesModel> obterDetalhes(int eventoId);
}

@LazySingleton(as: IEventoDetalhesRemoteDataSource)
class EventoDetalhesRemoteDataSource implements IEventoDetalhesRemoteDataSource {
  final EventoDetalhesRemoteService eventoDetalhesRemoteService;

  EventoDetalhesRemoteDataSource(this.eventoDetalhesRemoteService);

  @override
  Future<EventoDetalhesModel> obterDetalhes(int eventoId) async {
    try {
      final response = await eventoDetalhesRemoteService.obterDetalhesEvento(
        idEvento: eventoId,
      );

      return response.data;
    } on DioError catch (e) {
      throw handleNertorkError(e);
    }
  }
}
