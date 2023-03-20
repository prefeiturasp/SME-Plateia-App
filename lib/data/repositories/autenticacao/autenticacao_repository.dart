import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:sme_plateia/core/errors/failures.dart';
import 'package:sme_plateia/core/network/network_info.dart';
import 'package:sme_plateia/data/datasources/local/autenticacao/autenticacao_local_datasource.dart';
import 'package:sme_plateia/data/datasources/remote/autenticacao/autenticacao_remote_data_source.dart';
import 'package:sme_plateia/data/dtos/autenticacao/autenticacao_dto.dart';
import 'package:sme_plateia/domain/entities/autenticacao/autenticacao.dart';
import 'package:sme_plateia/domain/repositories/autenticacao/i_authentication_repository.dart';

@Injectable(as: IAutenticacaoRepository)
class AutenticacaoRepository implements IAutenticacaoRepository {
  final IAutenticacaoRemoteDataSource autenticacaoRemoteDataSource;
  final IAutenticacaoLocalDataSource autenticacaoLocalDataSource;
  final INetworkInfo networkInfo;

  AutenticacaoRepository(
    this.autenticacaoRemoteDataSource,
    this.autenticacaoLocalDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, Autenticacao>> autenticar(
    String login,
    String senha,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await autenticacaoRemoteDataSource.autenticar(
          login: login,
          senha: senha,
        );

        final Autenticacao autenticacao = result;

        autenticacaoLocalDataSource.cacheToken(autenticacao as AutenticacaoDto);

        return Right(autenticacao);
      } catch (e) {
        debugPrint(e.toString());
        return Left(ServerFailure());
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }
}
