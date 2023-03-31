import 'package:dartz/dartz.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';
import 'package:sme_plateia/features/auth/domain/entities/autenticacao.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

abstract class IAutenticacaoRepository {
  Stream<AuthenticationStatus> get status;

  Future<Either<Failure, Autenticacao>> autenticar(String login, String senha);
  Future<Either<Failure, Autenticacao?>> getUsuarioAutenticado();
  Future<Either<Failure, Unit>> fazerLogout();
  Future<void> dispose();
}
