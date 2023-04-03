import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';
import 'package:sme_plateia/core/interfaces/i_usecase.dart';
import 'package:sme_plateia/features/auth/domain/entities/autenticacao.dart';
import 'package:sme_plateia/features/auth/domain/repositories/i_authentication_repository.dart';

@injectable
class AutenticarUseCase implements IUseCase<Autenticacao, Params> {
  final IAutenticacaoRepository repository;

  AutenticarUseCase(
    this.repository,
  );

  @override
  Future<Either<Failure, Autenticacao>> call(Params params) async {
    return await repository.autenticar(params.login, params.senha);
  }
}

class Params extends Equatable {
  final String login;
  final String senha;

  const Params({
    required this.login,
    required this.senha,
  });

  @override
  List<Object> get props => [login, senha];
}
