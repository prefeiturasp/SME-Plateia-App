import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';
import 'package:sme_plateia/core/domain/usecases/use_case.dart';
import 'package:sme_plateia/features/eventos/data/repositories/local_evento_repository.dart';
import 'package:sme_plateia/features/eventos/domain/repositories/i_local_evento_repository.dart';

@LazySingleton()
class ObterLocaisEventosUsecase extends UseCase<List<String>, Params> {
  final ILocalEventoRepository localEventoRepository;

  ObterLocaisEventosUsecase(this.localEventoRepository);

  @override
  Future<Either<Failure, List<String>>> call(Params params) async {
    var result = await localEventoRepository.obterLocais(
      termo: params.termo,
    );
    return result;
  }
}

class Params extends Equatable {
  final String termo;

  Params({required this.termo});

  @override
  List<Object?> get props => [termo];
}
