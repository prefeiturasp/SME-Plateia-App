import 'package:dartz/dartz.dart';
import 'package:sme_plateia/core/errors/failures.dart';
import 'package:sme_plateia/domain/entities/autenticacao/autenticacao.dart';

abstract class IAutenticacaoRepository {
  Future<Either<Failure, Autenticacao>> autenticar(
    String login,
    String senha,
  );
}
