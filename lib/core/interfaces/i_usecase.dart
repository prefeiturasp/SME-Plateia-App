import 'package:dartz/dartz.dart';
import 'package:sme_plateia/core/errors/failures.dart';

abstract class IUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
