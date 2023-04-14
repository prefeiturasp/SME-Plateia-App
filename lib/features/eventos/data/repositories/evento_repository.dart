import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:sme_plateia/app/network/network_info.dart';
import 'package:sme_plateia/features/eventos/data/datasources/evento_local_data_source.dart';
import 'package:sme_plateia/features/eventos/data/datasources/evento_remote_data_source.dart';
import 'package:sme_plateia/features/eventos/data/model/evento_resumo.model.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_resumo.entity.dart';
import 'package:sme_plateia/features/eventos/domain/entities/enums/evento_periodo.enum.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';
import 'package:dartz/dartz.dart';
import 'package:sme_plateia/features/eventos/domain/repositories/i_evento_repository.dart';

@LazySingleton(as: IEventoRepository)
class EventoRepository implements IEventoRepository {
  final INetworkInfo networkInfo;
  final IEventoLocalDataSource eventoLocalDataSource;
  final IEventoRemoteDataSource eventoRemoteDataSource;

  EventoRepository(this.networkInfo, this.eventoLocalDataSource, this.eventoRemoteDataSource);

  @override
  Future<Either<Failure, List<EventoResumo>>> obterEventos({
    String? nome,
    EnumEventoPeriodo? periodo,
    String? local,
    int? pagina,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        DateTime? inicio;
        DateTime? fim;

        if (periodo != null && periodo != EnumEventoPeriodo.todos) {
          var hoje = DateTime.now();
          inicio = hoje.subtract(Duration(days: periodo.dias));
          fim = hoje;
        }

        final result = await eventoRemoteDataSource.obterEventos(
          nome: nome,
          local: local,
          pagina: pagina,
          periodoInicio: inicio,
          periodoFim: fim,
        );

        final List<EventoResumoModel> listEventosResumoModel = result;
        var listEventosResumo = listEventosResumoModel.map((e) => e.toDomain()).toList();

        await eventoLocalDataSource.deleteAll();
        await eventoLocalDataSource.saveAll(listEventosResumo);

        return Right(listEventosResumo);
      } else {
        return Right(await eventoLocalDataSource.findAll());
      }
    } on Failure catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure(message: e.message));
    }
  }
}
