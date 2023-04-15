import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:sme_plateia/app/network/network_info.dart';
import 'package:sme_plateia/features/eventos/data/datasources/evento_detalhes_local_data_source.dart';
import 'package:sme_plateia/features/eventos/data/datasources/evento_detalhes_remote_data_source.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_detalhes.entity.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';
import 'package:dartz/dartz.dart';
import 'package:sme_plateia/features/eventos/domain/repositories/i_evento_detalhes_repository.dart';

@LazySingleton(as: IEventoDetalhesRepository)
class EventoDetalhesRepository implements IEventoDetalhesRepository {
  final INetworkInfo networkInfo;
  final IEventoDetalhesLocalDataSource eventoDetalhesLocalDataSource;
  final IEventoDetalhesRemoteDataSource eventoDetalhesRemoteDataSource;

  EventoDetalhesRepository(this.networkInfo, this.eventoDetalhesLocalDataSource, this.eventoDetalhesRemoteDataSource);

  @override
  Future<Either<Failure, EventoDetalhes>> obterDetalhes(int eventoId) async {
    try {
      if (await networkInfo.isConnected) {
        var detalhes = await eventoDetalhesRemoteDataSource.obterDetalhes(eventoId);

        await eventoDetalhesLocalDataSource.insertOrUpdateEntity(detalhes.toDomain());

        return Right(detalhes.toDomain());
      } else {
        var eventoCache = await eventoDetalhesLocalDataSource.findById(eventoId);

        if (eventoCache != null) {
          return Right(eventoCache);
        } else {
          return Left(Failure.localFailure(message: 'Cache não encontrado para o evento ID $eventoId'));
        }
      }
    } on Failure catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure(message: e.message));
    }
  }
}
