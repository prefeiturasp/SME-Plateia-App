import 'package:dartz/dartz.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';

abstract class ILocalEventoRepository {
  Future<Either<Failure, List<String>>> obterLocais({
    required String termo,
  });
}
