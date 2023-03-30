import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:template/core/domain/failures/failure.codegen.dart';
import 'package:template/core/domain/usecases/use_case.dart';
import 'package:template/core/interfaces/i_usecase.dart';
import 'package:template/features/auth/domain/repositories/i_authentication_repository.dart';

@injectable
class FazerLogoutUseCase implements IUseCase<Unit, NoParams> {
  final IAutenticacaoRepository repository;

  FazerLogoutUseCase(
    this.repository,
  );

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await repository.fazerLogout();
  }
}
