import 'package:dartz/dartz.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';

abstract class IUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class IUseCaseOption<Type, Params> {
  Future<Option<Type>> call(Params params);
}
