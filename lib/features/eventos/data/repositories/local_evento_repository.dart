import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:sme_plateia/app/network/network_info.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';
import 'package:sme_plateia/features/eventos/data/datasources/local_evento_remote_data_source.dart';
import 'package:sme_plateia/features/eventos/domain/repositories/i_local_evento_repository.dart';

@LazySingleton(as: ILocalEventoRepository)
class LocalEventoRepository implements ILocalEventoRepository {
  final INetworkInfo networkInfo;
  final ILocalEventoRemoteDataSource localEventoRemoteDataSource;

  LocalEventoRepository(this.networkInfo, this.localEventoRemoteDataSource);

  @override
  Future<Either<Failure, List<String>>> obterLocais({
    required String termo,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await localEventoRemoteDataSource.obterLocais(
          termo: termo,
        );

        return Right(result);
      } else {
        return Left(Failure.noConnectionFailure());
      }
    } on Failure catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure(message: e.message));
    }
  }
}
